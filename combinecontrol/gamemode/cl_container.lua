GM.containers = {}

function GM:createContainerMenu()
	CCP.container = vgui.Create("DFrame")
	CCP.container:SetSize(800, 456)
	CCP.container:Center()
	CCP.container:SetTitle("Storage")
	CCP.container.lblTitle:SetFont("CombineControl.Window")
	CCP.container:MakePopup()
	CCP.container.PerformLayout = CCFramePerformLayout
	CCP.container:PerformLayout()

	
	CCP.container.contBut = vgui.Create("DButton", CCP.container)
	CCP.container.contBut:SetFont("CombineControl.LabelSmall")
	CCP.container.contBut:SetText("Storage")
	CCP.container.contBut:SetPos(10, 34)
	CCP.container.contBut:SetSize(100, 20)
	CCP.container.contBut:PerformLayout()

	function CCP.container.contBut:DoClick()
		CCP.container.localInv = false
		GAMEMODE:populateContainerMenu(GAMEMODE.containers[CCP.container.id])
	end

	CCP.container.plyBut = vgui.Create("DButton", CCP.container)
	CCP.container.plyBut:SetFont("CombineControl.LabelSmall")
	CCP.container.plyBut:SetText("Backpack")
	CCP.container.plyBut:SetPos(120, 34)
	CCP.container.plyBut:SetSize(100, 20)
	CCP.container.plyBut:PerformLayout()

	function CCP.container.plyBut:DoClick()
		CCP.container.localInv = true
		GAMEMODE:populateContainerMenu(LocalPlayer().Inventory)
	end

	CCP.container.model = vgui.Create("DModelPanel", CCP.container)
	CCP.container.model:SetPos(420, 64)
	CCP.container.model:SetModel("")
	CCP.container.model:SetSize(CCP.container:GetWide() - 430, 200)
	CCP.container.model:SetFOV(20)
	CCP.container.model:SetCamPos(Vector(50, 50, 50))
	CCP.container.model:SetLookAt(Vector(0, 0, 0))

	function CCP.container.model:LayoutEntity() end
	
	local p = CCP.container.model.Paint
	
	function CCP.container.model:Paint(w, h)
		surface.SetDrawColor(30, 30, 30, 150)
		surface.DrawRect(0, 0, w, h)
		
		surface.SetDrawColor(20, 20, 20, 100)
		surface.DrawOutlinedRect(0, 0, w, h)
		
		p(self, w, h)
	end

	CCP.container.title = vgui.Create("DLabel", CCP.container)
	CCP.container.title:SetText("")
	CCP.container.title:SetPos(420, 274)
	CCP.container.title:SetFont("CombineControl.LabelGiant")
	CCP.container.title:SetSize(CCP.container:GetWide() - 430, 22)
	CCP.container.title:PerformLayout()

	CCP.container.desc = vgui.Create("DLabel", CCP.container)
	CCP.container.desc:SetText("No item selected.")
	CCP.container.desc:SetPos(420, 304)
	CCP.container.desc:SetFont("CombineControl.LabelSmall")
	CCP.container.desc:SetSize(CCP.container:GetWide() - 430, 14)
	CCP.container.desc:SetAutoStretchVertical(true)
	CCP.container.desc:SetWrap(true)
	CCP.container.desc:PerformLayout()

	CCP.container.inv = vgui.Create("DScrollPanel", CCP.container)
	CCP.container.inv:SetPos(10, 64)
	CCP.container.inv:SetSize(400, CCP.container:GetTall() - 80)

	function CCP.container.inv:Paint(w, h)
		surface.SetDrawColor(30, 30, 30, 150)
		surface.DrawRect(0, 0, w, h)
		
		surface.SetDrawColor(20, 20, 20, 100)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	CCP.container.moveBut = vgui.Create("DButton", CCP.container)
	CCP.container.moveBut:SetFont("CombineControl.LabelSmall")
	CCP.container.moveBut:SetText("Move item")
	CCP.container.moveBut:SetPos(CCP.container:GetWide() - 110, CCP.container:GetTall() - 30)
	CCP.container.moveBut:SetSize(100, 20)
	CCP.container.moveBut:PerformLayout()

	CCP.container.moveBut:SetDisabled(true)

function CCP.container.moveBut:DoClick()
    if CCP.container.localInv then
        net.Start("nPutIntoContainer")
            net.WriteString(CCP.container.id)
            net.WriteInt(CCP.container.selected, 32)
        net.SendToServer()

        timer.Simple(0.01, function()
            LocalPlayer():RemoveItem(CCP.container.selected)
            CCP.container:Close()  -- Close the container window

            -- Trigger the +use and -use actions quickly for putting item into container
            RunConsoleCommand("+use")  -- Simulate the player pressing +use
            timer.Simple(0.1, function()  -- Wait a brief moment before releasing -use
                RunConsoleCommand("-use")  -- Simulate releasing -use
            end)
        end)

        CCP.container.plyBut:DoClick() 
    else
        net.Start("nTakeFromContainer")
            net.WriteString(CCP.container.id)
            net.WriteInt(CCP.container.selected, 32)
        net.SendToServer()

        timer.Simple(0.01, function()
        	    CCP.container:Close()  -- Close the container window
            -- Trigger the +use and -use actions quickly for taking item from container
            RunConsoleCommand("+use")  -- Simulate the player pressing +use
            timer.Simple(0.1, function()  -- Wait a brief moment before releasing -use
                RunConsoleCommand("-use")  -- Simulate releasing -use
            end)
        end)
    end
end
 end
function GM:clearContainerSelection()
	CCP.container.model:SetModel("")
	CCP.container.title:SetText("")
	CCP.container.desc:SetText("No item selected.")

	CCP.container.selected = nil

	CCP.container.moveBut.itemData = nil
	CCP.container.moveBut:SetDisabled(true)
end

function GM:populateContainerMenu(tab) -- Inventory stacking code should be transferrable into other inventory displays without much issue
	self:clearContainerSelection()

	CCP.container.inv:Clear()

	local x = 0
	local y = 0

	local stackedInventory = {}

	for k, v in pairs(tab) do
		local stacked = false

		for _, j in pairs(stackedInventory) do
			if j[2] == v then
				j[3] = j[3] + 1
				stacked = true

				break
			end
		end

		if not stacked then
			local stack = {}
			stack[1] = k -- Inventory ID for the first item in the stack (Used when interacting with the stack)
			stack[2] = v -- The item itself
			stack[3] = 1 -- Stack count

			table.insert(stackedInventory, stack)
		end
	end

	for _, v in pairs(stackedInventory) do
		local icon = vgui.Create("DModelPanel", CCP.container.inv)
		icon.item = v[2]
		icon.inventoryID = v[1]

		local itemData = GAMEMODE:GetItemByID(v[2])

		if not itemData then
			continue
		end

		icon:SetPos(x, y)
		icon:SetModel(itemData.Model)
		icon:SetSize(48, 48)

		if v[3] > 1 then
			local label = vgui.Create("DLabel", icon)
			label:SetPos(0, 0)
			label:SetSize(48, 48)
			label:SetFont("CombineControl.LabelSmall")
			label:SetText(v[3])
			label:SetContentAlignment(3)
		end
		
		if itemData.LookAt then
			icon:SetFOV(itemData.FOV)
			icon:SetCamPos(itemData.CamPos)
			icon:SetLookAt(itemData.LookAt)
		else
			local a, b = icon.Entity:GetModelBounds()
			
			icon:SetFOV(20)
			icon:SetCamPos(Vector(math.abs(a.x), math.abs(a.y), math.abs(a.z)) * 5)
			icon:SetLookAt((a + b) / 2)
		end
		
		if itemData.IconMaterial then
			icon.Entity:SetMaterial(itemData.IconMaterial)
		end

		if itemData.IconColor then
			icon.Entity:SetColor(itemData.IconColor)
		end
		
		function icon:LayoutEntity() end
		x = x + 48 + 10
		
		if x > CCP.container.inv:GetWide() - 48 then
			x = 0
			y = y + 48 + 10
		end
		
		local p = icon.Paint
		
		function icon:Paint(w, h)
			local pnl = self:GetParent():GetParent()
			local x2, y2 = pnl:LocalToScreen(0, 0)
			local w2, h2 = pnl:GetSize()

			render.SetScissorRect(x2, y2, x2 + w2, y2 + h2, true)
			
			p(self, w, h)
			
			render.SetScissorRect(0, 0, 0, 0, false)
		end
		
		function icon:DoClick()
			if CCP.container.model.Entity and CCP.container.model.Entity:IsValid() then
				CCP.container.model.Entity:SetMaterial("")
				CCP.container.model.Entity:SetColor(Color(255, 255, 255, 255))
			end
			
			CCP.container.model:SetModel(itemData.Model)
			CCP.container.title:SetText(itemData.Name.." x"..v[3])
			CCP.container.desc:SetText(itemData.Description)
			
			if itemData.LookAt then
				CCP.container.model:SetFOV(itemData.FOV)
				CCP.container.model:SetCamPos(itemData.CamPos)
				CCP.container.model:SetLookAt(itemData.LookAt)
			else
				local a, b = CCP.container.model.Entity:GetModelBounds()
				
				CCP.container.model:SetFOV(20)
				CCP.container.model:SetCamPos(Vector(math.abs(a.x), math.abs(a.y), math.abs(a.z)) * 5)
				CCP.container.model:SetLookAt((a + b) / 2)
			end
			
			if itemData.IconMaterial then
				CCP.container.model.Entity:SetMaterial(itemData.IconMaterial)
			end

			if itemData.IconColor then
				CCP.container.model.Entity:SetColor(itemData.IconColor)
			end

			CCP.container.selected = self.inventoryID

			if LocalPlayer():CanTakeItem(self.item) or CCP.container.localInv then
				CCP.container.moveBut:SetDisabled(false)
			else
				CCP.container.moveBut:SetDisabled(true)
			end
		end
	end

	if CCP.container.localInv then
		CCP.container.plyBut:SetDisabled(true)
		CCP.container.contBut:SetDisabled(false)
	else
		CCP.container.plyBut:SetDisabled(false)
		CCP.container.contBut:SetDisabled(true)
	end
end

function nCOpenContainer(len)
	local id = net.ReadString()

	GAMEMODE:createContainerMenu()

	CCP.container.id = id
	CCP.container.localInv = false

	GAMEMODE:populateContainerMenu(GAMEMODE.containers[id])
end
net.Receive("nCOpenContainer", nCOpenContainer)

function nCSetContainer(len)
	local id = net.ReadString()
	local tab = net.ReadTable()

	GAMEMODE.containers[id] = tab

	if CCP.container and CCP.container.id == id and not CCP.container.localInv then
		GAMEMODE:populateContainerMenu(tab)
	end
end
net.Receive("nCSetContainer", nCSetContainer)

function nCContainerPassword(len)
	local id = net.ReadString()

	CCP.containerPassword = vgui.Create("DFrame")
	CCP.containerPassword:SetSize(250, 114)
	CCP.containerPassword:Center()
	CCP.containerPassword:SetTitle("Unlock Storage Unit")
	CCP.containerPassword.lblTitle:SetFont("CombineControl.Window")
	CCP.containerPassword:MakePopup()
	CCP.containerPassword.PerformLayout = CCFramePerformLayout
	CCP.containerPassword:PerformLayout()
	CCP.containerPassword.Think = genericWindowThink
	
	CCP.containerPassword.entry = vgui.Create("DTextEntry", CCP.containerPassword)
	CCP.containerPassword.entry:SetFont("CombineControl.LabelBig")
	CCP.containerPassword.entry:SetPos(10, 34)
	CCP.containerPassword.entry:SetSize(100, 30)
	CCP.containerPassword.entry:PerformLayout()
	CCP.containerPassword.entry:RequestFocus()
	CCP.containerPassword.entry:SetNumeric(true)

	function CCP.containerPassword.entry:OnEnter()
		CCP.containerPassword.confirm:DoClick()
	end
	
	CCP.containerPassword.confirm = vgui.Create("DButton", CCP.containerPassword)
	CCP.containerPassword.confirm:SetFont("CombineControl.LabelSmall")
	CCP.containerPassword.confirm:SetText("Confirm")
	CCP.containerPassword.confirm:SetPos(180, 74)
	CCP.containerPassword.confirm:SetSize(60, 30)

	function CCP.containerPassword.confirm:DoClick()
		net.Start("nContainerPassword")
			net.WriteString(id)
			net.WriteString(CCP.containerPassword.entry:GetValue())
		net.SendToServer()

		CCP.containerPassword:Remove();
	end
end
net.Receive("nCContainerPassword", nCContainerPassword)

function nCBrokenContainer(len)
	GAMEMODE:AddChat(Color(200, 0, 0, 255), "CombineControl.ChatNormal", "Something went wrong!", {CB_ALL, CB_OOC})
end
net.Receive("nCBrokenContainer", nCBrokenContainer)

function nCLockedContainer(len)
	GAMEMODE:AddChat(Color(200, 0, 0, 255), "CombineControl.ChatNormal", "The container is locked shut.", {CB_ALL, CB_OOC})
end
net.Receive("nCLockedContainer", nCLockedContainer)