local key = require 'vkeys'
local sf = require 'sampfuncs'
local moon = require "lib.moonloader" 
local sampev = require 'lib.samp.events'

local TRUE = false
local dissync = false
local pointx, pointy, pointz = 0, 0, 0

local turn = false 
local act = false
local active = false
local state = false
local deff = false
local turn = false
local switch = false
local vkl = false
local power = false

local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'

update_state = false

local script_vers = 2
local scrip_vers_text = "2.00"

local update_url = "https://raw.githubusercontent.com/KohanSlipsize/AdminPanel/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://github.com/KohanSlipsize/AdminPanel/blob/main/AdminPanel.luac?raw=true"
local script_path = thisScript().path

_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
name = sampGetPlayerNickname(id)

local my_dialog = {
    {
        title = '{00FF00}����-�������: {FFFFFF}������ �� ����� ���������.',
        onclick = function() deff = not deff 
	        if not deff then 
	            sampAddChatMessage('{00FF00}[����-�������]: {FFFFFF}��������!', -1)
	        else 	
	            sampAddChatMessage('{00FF00}[����-�������]: {FFFFFF}�������!', -1)
	        end
	    end
    },
	
	{
        title = '{00FF00}���� �����: {FFFFFF}���� ����� �� ������.',
        onclick = function() bool = not bool 
	        if not bool then 
	            sampAddChatMessage('{00FF00}[���� �����]: {FFFFFF}��������!', -1)
	        else	
	            sampAddChatMessage('{00FF00}[���� �����]: {FFFFFF}�������!', -1)
	        end
	    end
    },

    {
        title = '{00FF00}�������: {FFFFFF}���������� ����� �������.',
        onclick = function() deff = not deff 
	        sampSendChat('/apanel') 
	    end
    },

    {
        title = '{00FF00}Admins: {FFFFFF}������� ��� ��������� ��������������� � ����.',
        onclick = function() deff = not deff 
			sampSendChat('/admins')  	
	    end
    },

    {
        title = '{00FF00}�������: {FFFFFF}������� ��� ����, ����� �������� ������� �� ���� ������.',
        onclick = function() deff = not deff 
	        sampSendChat('/o ��� ������? ���������! ������ � ��� � ������ � /donate')
            sampSendChat('/o ������� ������� �� �������� �������! ��������� X2 �����!')
            sampSendChat('/o ������ ������� �����! ������� 1 ��� �����-������ �� 50 ������!')  
	    end
    },

    {
        title = '{00FF00}������: {FFFFFF}������� ��� ��������� ������ �������.',
        onclick = function() deff = not deff 
	        sampSendChat('/leaders')
	    end
    },

    {
        title = '{00FF00}�������: {FFFFFF}���������� ������� �������� � ����.',
        onclick = function() deff = not deff 
	        sampSendChat('/helpers')
	    end
    },

    {
        title = '{00FF00}����� ������(��): {FFFFFF}������ ����� ������ � ��������? ������.',
        onclick = function() deff = not deff 
	        sampSendChat('/checkleaders')
	    end
    },

    {
        title = '{00FF00}����� ����������: {FFFFFF}���������� ��������� �� ��� �������.',
        onclick = function() deff = not deff 
	        sampSendChat('/spcars')
	    end
    },

    {
        title = '{00FF00}����� ���������� � �������: {FFFFFF}���������� ��������� � ������� "10".',
        onclick = function() deff = not deff 
	        sampSendChat('/spveh 10') 
	    end
    },

    {
        title = '{00FF00}�����: {FFFFFF}������ ������� ����? �����!',
        onclick = function() deff = not deff 
	        sampSendChat('������������ ������ � ����� �����.')
            sampSendChat('� ������� � � ���� ������� ������� ������')
            sampSendChat('��� � ������� ��� �������� ��� � ������� �����...')
            sampSendChat('� �."Los-Santos" 6.2 (�).������� ����� �������')  
            sampSendChat('� �."San-Fierro" -10.8 (�).����� ������ �������')  
            sampSendChat('� � �."Las-Venturas" 12.2 (�).���� ���� ����� ���� �����')  
            sampSendChat('� ���� �� ���� ���.������� �� ��������.����� ��������.')
	    end
    },

    {
        title = '{00FF00}��������� ���������: {FFFFFF}��������� ��������� �� ��� �������.',
        onclick = function() deff = not deff 
	        sampSendChat('/fuelcars') 
	    end
    },

    {
        title = '{00FF00}�������� ������: {FFFFFF}�������� ������ � ������� �� ������.',
        onclick = function() deff = not deff 
	        sampSendChat('/hp')
	    end
    },

    {
        title = '{00FF00}������������ ��������� � ��������: {FFFFFF}� ����� ��� ����������� ���������� � ��������.',
        onclick = function() deff = not deff 
	        sampSendChat('/a �������� �������������! �� ������ ������ � ��� �������� ��������!')
            sampSendChat('/a �������� �������������! �� ������ ������ � ��� �������� ��������!') 
            sampSendChat('/a �������� �������������! �� ������ ������ � ��� �������� ��������!') 
            sampSendChat('/a �������� �������������! �� ������ ������ � ��� �������� ��������!') 
	    end
    },

    {
          title = '{00FF00}���� �����������{FFFFFF} �������	',
        submenu = {
            {
                title = '{00FF00}������� ����� ��� ��: {FFFFFF}����� �������� ����� ����� ��������� �� �� ��.',
                onclick = function() deff = not deff 
			        sampSendChat('/mark')	
	                sampAddChatMessage('{00FF00}[�������� ����� ��� �� �� ��]: {FFFFFF}������� �������!', -1)
				end
            },
            {
                title = '{00FF00}MenuMP: {FFFFFF}������� ���� �����������.',
                onclick = function() deff = not deff 
                    sampSendChat('/mp')
				end				
			},
            {
                title = '{00FF00}King of Eagle: {FFFFFF}�������� ������ �����.',
                onclick = function() deff = not deff 
                    sampShowDialog(1337, "������ �����", "������� ����", "����������", "�������", 1)
	                lua_thread.create(kingofeagle)
				end				
			},
            {
                title = '{00FF00}��: {FFFFFF}�������� ������� �������.',
                onclick = function() deff = not deff 
                    sampShowDialog(1338, "������� �������", "������� ����", "����������", "�������", 1)
	                lua_thread.create(kingofeagle)
				end				
			},
            {
                title = '{00FF00}������: {FFFFFF}�������� ������.',
                onclick = function() deff = not deff 
                    sampShowDialog(1339, "������", "������� ����", "����������", "�������", 1)
	                lua_thread.create(pryatki)
				end				
			},
		    {
                title = '{00FF00}Race: {FFFFFF}��������� ����� �� ��� �������.',
                onclick = function() deff = not deff 
	                sampSendChat('/arace')
	            end
            },
		    {
                title = '{00FF00}Race: {FFFFFF}������� �������� �� �����(���������� ��������� � ����� �����������).',
                onclick = function() deff = not deff 
	                sampSendChat('/arace')
					sampSendChat('/o �������� �������� �� �����')
					sampSendChat('/mark')
					sampSendChat('/mp')
	            end
            },
            {
                title = '{00FF00}PaintBall: {FFFFFF}��������� PaintBall �� ��� �������.',
                onclick = function() deff = not deff 
			        sampSendChat('/apaint')
	            end
            },
		    {
                title = '{00FF00}PaintBall: {FFFFFF}������� �������� �� PaintBall(���������� ��������� � ����� �����������).',
                onclick = function() deff = not deff 
	                sampSendChat('/apaint')
					sampSendChat('/o �������� �������� �� PaintBall')
					sampSendChat('/mark')
					sampSendChat('/mp')
	            end
            },
			{
                title = '{00FF00}����-����: {FFFFFF}C������ ����-����!',
                onclick = function() deff = not deff 
	                sampSendChat('/o ��������� ������, ������ ���������� ����-����.')
			        sampSendChat('/o ���� ������ ������� ��� cep�ep � ������� ����� ��� "Diadmond R�" � �.�.')
			        sampSendChat('/o ������� cep�e� ������ � ������� ����� ��� "����-�o���op���" � �.�. �����:')
			        sampSendChat('/o ����* ���������� - ���� �� ����� � 2.000�o����. ������* - 200���� ����������.')  
			        sampSendChat('/o ��������* - +6 ��� � 3.000������, ��������* - �������� 1 ������.')  
			        sampSendChat('/o ���������* �������� 3 ������ (����� ������������ �������)')  
			        sampSendChat('/o ��������� ������ ���� - v�.��m/er�lif� (*����������� �������� ���� ��� � ��� ��������������!)')
			        sampSendChat('/o ����� ������� �� ����-����: /ac mp')
			        sampSendChat('/mark')
			        sampSendChat('/mp')
	            end
            },
        },
    },

{
    title = '{00FF00}��������� ������� �������� ( ������������� ��� {FF1221}��{00FF00} ): {FFFFFF}��������� ������� ��������, � �� ��� ������.',
    onclick = function() deff = not deff 
        sampSendChat('/a �������� ��������������! ��������! ����� �������, ������ ��, ������ �������, �������� �� �������!')
        sampSendChat('/a �������� ��������������! ��������! ����� �������, ������ ��, ������ �������, �������� �� �������!') 
        sampSendChat('/a �������� ��������������! ��������! ����� �������, ������ ��, ������ �������, �������� �� �������!') 
        sampSendChat('/a �������� ��������������! ��������! ����� �������, ������ ��, ������ �������, �������� �� �������!') 
        sampSendChat('/a �������� ��������������! ��������! ����� �������, ������ ��, ������ �������, �������� �� �������!')
    end
},

{
    title = '{00FF00}��������� ������� ������ ������: {FFFFFF}��������� ������� � �� ����� ������ ������ � ��.',
    onclick = function() deff = not deff 
        sampSendChat('/o ��������! ������ � �� ����, ������� ������, ��������� ��, ������� ����� ������� � ��� ���������� ����� ������!')
        sampSendChat('/o ��������! ������ � �� ����, ������� ������, ��������� ��, ������� ����� ������� � ��� ���������� ����� ������!') 
    end
},

{
      title = '{00FF00}�������� ����������',
    submenu = {
        {
            title = '{FFFFFF}������ ������� {00FF00}"����-�������" {FFFFFF}����� �� ������ ���� � �����������.',	
        },
    },
}, 

}

--�����
function kingofeagle()
while sampIsDialogActive() do
    wait(0)
    local result, button, list, input = sampHasDialogRespond(1337)
    if result and button == 1 then
        sampSendChat('/o ��������� ������!')
        sampSendChat('/o ������ ������ �� "������ �����" ')
        sampSendChat("/o ����: "..input)
        sampSendChat('/o ����� ������� �� ��: /ac mp')
        sampSendChat('/o ����� ��������� ����� � �����!')
        sampSendChat('/mark')
        sampSendChat('/mp')
    end
end
end	

function russianryletka()
while sampIsDialogActive() do
    wait(0)
    local result, button, list, input = sampHasDialogRespond(1338)
    if result and button == 1 then
        sampSendChat('/o ��������� ������!')
        sampSendChat('/o ������ ������ �� "������� �������" ')
        sampSendChat("/o ����: "..input)
        sampSendChat('/o ����� ������� �� ��: /ac mp')
        sampSendChat('/o ����� ��������� ����� � �����!')
        sampSendChat('/mark')
        sampSendChat('/mp')
    end
end
end	

function pryatki()
    while sampIsDialogActive() do
        wait(0)
        local result, button, list, input = sampHasDialogRespond(1339)
        if result and button == 1 then
            sampSendChat('/o ��������� ������!')
            sampSendChat('/o ������ ������ �� "������" ')
            sampSendChat("/o ����: "..input)
            sampSendChat('/o ����� ������� �� ��: /ac mp')
            sampSendChat('/o ����� ��������� ����� � �����!')
            sampSendChat('/mark')
            sampSendChat('/mp')
        end
    end
    end	
--�����



function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	    sampAddChatMessage('{00FF00}[Admin Panel ETRP]: {FFFFFF}������ ������� ��������! {00FF00}(By Vollar. Edited by Kohan)', -1)
		thr1 = lua_thread.create_suspended(SpawnCarInPoint)
	sampRegisterChatCommand("nop", function() nop = not nop 
	--	if not nop then 
	--	sampAddChatMessage('{00FF00}[Nop]: {FFFFFF}��������!', -1)
	--	else
	--	sampAddChatMessage('{00FF00}[Nop]: {FFFFFF}�������!', -1)
	--	end
	end) 

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("{00FF00}[Admin Panel ETRP]: {ff0000}�������� ����������: {FFFFFF}����� ������: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end             
    end)
    
	sampRegisterChatCommand('etp', function() power = not power
		if not power then 
		    sampAddChatMessage('{00FF00}[ETeleport]: {FFFFFF}��������!', -1)
		else
		    sampAddChatMessage('{00FF00}[ETeleport]: {FFFFFF}�������!', -1)
			lua_thread.create(Teleport)
	    end
    end)
	
    while true do
        wait(0)
        if wasKeyPressed(VK_3) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then
            submenus_show(my_dialog, '{00FF00}Admin Panel (By Vollar. Edited by Kohan)')
        end	

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("{00FF00}[Admin Panel ETRP]{FFFFFF}: ������� ���������! ������� ������������ �������", -1)
                    thisScript():reload()
                end             
            end)
            break
        end
		
		local result, target = getCharPlayerIsTargeting(playerHandle)
            if result then 
		        result, playerid = sampGetPlayerIdByCharHandle(target) 
		        if result and turn then 
	                sampSendChat('/sd '..playerid)
	                sampSendDialogResponse(sampGetCurrentDialogId(), 1 , 0 , '')
                end
	        end
    
	    if act then 	 
            local x, y, z = getCharCoordinates(PLAYER_PED) 
            local valid, ped = findAllRandomCharsInSphere(x, y, z, 12, true, false)
		    if valid then 
                local _, id = sampGetPlayerIdByCharHandle(ped)
			    if _ then
				    sampSendChat('/sd '..id)
                    sampSendDialogResponse(sampGetCurrentDialogId(), 1 , 0 , '')
			    end
            end 
        end  

        if active then 
		    local _, ped = sampGetCharHandleBySampPlayerId(id)
		    if _ then
		        sampSendChat('/sd '..id)
	            sampSendDialogResponse(sampGetCurrentDialogId(), 1 , 0 , '')
		    end	
		end
    end	
end

-- func was made by mrcreepton:
function SpawnCarInPoint()    
	while true do
		wait(0)
		if TRUE and isCharOnFoot(PLAYER_PED) then
			TRUE = false
			sampAddChatMessage('{FF33CC}[SpawnCarInPoint]: {FFFFFF}�� ����� �� ����, ������ ��������!', -1)
		end
	    
		if TRUE and isCharInAnyCar(PLAYER_PED) then
			local veh = getCarCharIsUsing(PLAYER_PED)
			local _, vid = sampGetVehicleIdByCarHandle(veh)
			local x, y, z = getCarCoordinates(veh)
			local _, fveh = findAllRandomVehiclesInSphere(x, y, z, 1000, true, true)
			if _ then
				local _, fvid = sampGetVehicleIdByCarHandle(fveh)
				if _ then
		            dissync = true
				    local data = samp_create_sync_data('vehicle')
				    data.vehicleId = vid
					data.vehicleHealth = getCarHealth(veh)
					data.playerHealth = getCharHealth(PLAYER_PED)
					data.armor = getCharArmour(PLAYER_PED)
					data.position.x, data.position.y, data.position.z = getCarCoordinates(veh)
					data.trailerId = fvid
					data.send()
					local data = samp_create_sync_data('trailer')
					data.trailerId = fvid
					data.position.x, data.position.y, data.position.z = pointx, pointy, pointz
					data.send()
					dissync = false
		        end
	        end
        end
    end
end

function Teleport()
    while true do 
	    wait(0)
	    if power then
        printString('~r~ TELEPORTATION...', 7000)
        local res, x, y, z = getTargetBlipCoordinatesFixed()
			if res then
                setCharHealth(PLAYER_PED, 0)
			    wait(5000)
                setCharCoordinates(PLAYER_PED, x, y, z)
                power = false
			else sampAddChatMessage('{FF33CC}[ETeleport]: {FFFFFF}��������� ����� �� ����� ��� ���������.', -1)
			    power = false
            end
        end
	end
end

function getTargetBlipCoordinatesFixed()
    local res, x, y, z = getTargetBlipCoordinates(); 
	if not res then 
     	return false 
	end
	    requestCollision(x, y); 
		loadScene(x, y, z)
		local res, x, y, z = getTargetBlipCoordinates()
		return res, x, y, z
end
	
function sampev.onServerMessage(color, text)
    if text:find("����� ������ �� ���.") then 
	    return false
    elseif text:find("������������") then
        return false
    elseif text:find("����� �� ������") then
        return false
	elseif text:find("�� �����!") then
        return false	
    end
	
	if bool then 		
	    if text:find("%[������%] �� ") or text:find("%[������%] �� ") then
		   if text:match('%[(%d+)%]: (.*)') then
			    id, other = text:match('%[(%d+)%]: (.*)')
				lua_thread.create(function() 
			        wait(1000)
				    sampSendChat('/pm '..id..' ������������! ������� �������� �� ����� ������! ����� �������� ���� �� �������!') 
                end)
            end
        end
    end
	
	if state then 
	    if text:find("��������!!������������� �������� ������� �� ����� ������!!!") then
	        lua_thread.create(function() 
	            sampSendChat('/adminka') 
		        wait(1000)
                sampSendDialogResponse(sampGetCurrentDialogId(), 1 , 2 , '')
	            sampCloseCurrentDialogWithButton(0)
            end)
        end
    end
		
    if vkl then 
       	lua_thread.create(function()
		    while true do
			    wait(10000)
			    if not vkl then break end
	                if text:find("AFK") then
			            if text:match("%[(%d+)%]") then
		                    pid = text:match("%[(%d+)%]")
                            local _, ped = sampGetCharHandleBySampPlayerId(pid)
							if not _ then 							
			                    sampSendChat('/sd '..pid)
		                    end
			            end
	                end
		    end
	    end)
	end
end  

function sampev.onShowDialog(a,b,c,d,h,j)
    if c:find("����� ���������") and isKeyDown(VK_RBUTTON) then
        return false
	elseif c:find("Passport") and deff then
        return false
    end	

    if vkl then
        if j:find("������� �� ����") then
		    sampAddChatMessage('{FF33CC}[AChecker]: {FFFFFF}�� ���� ������ �������������!' , -1)
			sampAddChatMessage('{FF33CC}[AChecker]: {FFFFFF}����� � ����� {FF33CC}NO RECON{FFFFFF}, ������� {FF33CC}J', -1)
			sampAddChatMessage('{FF33CC}[AChecker]: {FFFFFF}����� �� ������ {FF33CC}NO RECON{FFFFFF}, ������� {FF33CC}L', -1)
			lua_thread.create(function()
			    while true do
	                wait(0)
			        if vkl and isKeyJustPressed(VK_J) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then
			            sampSendClickTextdraw(65)
			            wait(5000)
					elseif vkl and isKeyJustPressed(VK_L) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then
					    sampProcessChatInput('/nop')
					    wait(500)
						setCharHealth(PLAYER_PED, 0)
						wait(500)
						sampProcessChatInput('/nop')
					    wait(5000)
					end
			    end
			end)
            return false
        end
	end
end
				
function onSendRpc(id, bitStream, priority, reliability, orderingChannel, shiftTs)
    if nop and id == 129 then 
        return false 
	end
		
    if nop and id == 52 then 
		return false 
	end
end
				
function onReceiveRpc(id, bs)				
    if nop and id == 129 then 
	    nop = false
        return false 
    end	
end

function sampev.onSendPlayerSync(data)
	if nop then
		local sync = samp_create_sync_data('spectator')
		sync.position = data.position
		sync.send()
		return false
	end
end
 
function sampev.onSendVehicleSync(data)
	if dissync then
		return false
	end
end

function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require 'ffi'
    local sampfuncs = require 'sampfuncs'
    -- from SAMP.Lua
    local raknet = require 'samp.raknet'

    copy_from_player = copy_from_player or true
    local sync_traits = {
        player = {'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
        vehicle = {'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
        passenger = {'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
        aim = {'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
        trailer = {'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
        unoccupied = {'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil},
        bullet = {'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil},
        spectator = {'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil}
    }
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
    -- copy player's sync data to the allocated memory
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
    -- function to send packet
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
    -- metatable to access sync data and 'send' function
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({send = func_send}, mt)
end
	 
function submenus_show(menu, caption, select_button, close_button, back_button)
    select_button, close_button, back_button = select_button or '�������', close_button or '�������', back_button or '�����'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. '  >>' or v.title)
        end
        sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_LIST)
        repeat
            wait(0)
            local result, button, list = sampHasDialogRespond(id)
            if result then
                if button == 1 and list ~= -1 then
                    local item = menu[list + 1]
                    if type(item.submenu) == 'table' then -- submenu
                        table.insert(prev_menus, {menu = menu, caption = caption})
                        if type(item.onclick) == 'function' then
                            item.onclick(menu, list + 1, item.submenu)
                        end
                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
                    elseif type(item.onclick) == 'function' then
                        local result = item.onclick(menu, list + 1)
                        if not result then return result end
                        return display(menu, id, caption)
                    end
                else -- if button == 0
                    if #prev_menus > 0 then
                        local prev_menu = prev_menus[#prev_menus]
                        prev_menus[#prev_menus] = nil
                        return display(prev_menu.menu, id - 1, prev_menu.caption)
                    end
                    return false
                end
            end
        until result
    end
    return display(menu, 31337, caption or menu.title)
end