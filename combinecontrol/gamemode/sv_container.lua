local meta = FindMetaTable("Player")

function GM:loadContainers()
	MsgC(Color(200, 200, 200, 255), "Loading containers...\n")

	self.containers = {}

	local function qS(ret)
		for _, v in pairs(ret) do
			self.containers[v["ContainerID"]] = self:loadItemsFromString(v["Inventory"])

			MsgC(Color(200, 200, 200, 255), "Container '"..v["ContainerID"].."' loaded.\n")
		end

		if self.containerData then
			for _, v in pairs(self.containerData) do
				if not self.containers[v[3]] then
					self:createContainer(v[3])
				end
			end
		end

		MsgC(Color(200, 200, 200, 255), #ret.." containers loaded.\n")
	end

	local function qF(err)
		self.loadContainers()
	end

	mysqloo.Query("SELECT * FROM cc_containers", qS, qF)
end

function GM:saveContainer(id)
	local function qS(ret)
		self:LogSQL("Container '"..id.."' saved.")
	end

	local function qF(err)
		self:saveContainer(id)
	end

	local inv = self:saveItemsIntoString(self.containers[id])

	mysqloo.Query("UPDATE cc_containers SET Inventory = '"..mysqloo.Escape(inv).."' WHERE ContainerID = '"..mysqloo.Escape(id).."'", qS, qF)
end

function meta:requestContainers()
	for k, v in pairs(GAMEMODE.containers) do
		net.Start("nCSetContainer")
			net.WriteString(k)
			net.WriteTable(v)
		net.Send(self)
	end
end

function GM:createContainer(id)
	local function qS(ret)
		MsgC(Color(200, 200, 200, 255), "Container '"..id.."' created.\n")

		self:updateContainer(id, {})
	end

	local function qF(err)
		self:createContainer(id)
	end

	mysqloo.Query("INSERT INTO cc_containers (ContainerID, Inventory) VALUES ('"..mysqloo.Escape(id).."', '')", qS, qF)
end

function GM:updateContainer(id, tab)
	self.containers[id] = tab

	net.Start("nCSetContainer")
		net.WriteString(id)
		net.WriteTable(tab)
	net.Broadcast()

	self:saveContainer(id)
end

function nPutIntoContainer(len, ply)
	local containerID = net.ReadString()
	local itemID = net.ReadInt(32)

	local item = ply.Inventory[itemID]

	ply:RemoveItem(itemID, false)

	local tab = GAMEMODE.containers[containerID]

	table.insert(tab, item)

	GAMEMODE:updateContainer(containerID, tab)

	GAMEMODE:LogItems("[Containers] "..ply:VisibleRPName().." put item "..item.." into container "..containerID..".", ply)
end
net.Receive("nPutIntoContainer", nPutIntoContainer)

function nTakeFromContainer(len, ply)
	local containerID = net.ReadString()
	local itemID = net.ReadInt(32)

	local tab = GAMEMODE.containers[containerID]
	local item = tab[itemID]

	table.remove(tab, itemID)

	GAMEMODE:updateContainer(containerID, tab)

	ply:GiveItem(item, 1)

	GAMEMODE:LogItems("[Containers] "..ply:VisibleRPName().." took item "..item.." from container "..containerID..".", ply)
end
net.Receive("nTakeFromContainer", nTakeFromContainer)

function nContainerPassword(len, ply)
	local id = net.ReadString()
	local val = net.ReadString()

	local pass = nil

	for _, v in pairs(GAMEMODE.containerData) do
		if v[3] == id and v[4] == CONTAINER_PASSWORD then
			pass = v[5]
		end
	end

	if pass == val then
		net.Start("nCOpenContainer")
			net.WriteString(id)
		net.Send(ply)
	else
		net.Start("nCLockedContainer")
		net.Send(ply)
	end
end
net.Receive("nContainerPassword", nContainerPassword)