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
        title = '{00FF00}Анти-паспорт: {FFFFFF}Защита от спама паспортом.',
        onclick = function() deff = not deff 
	        if not deff then 
	            sampAddChatMessage('{00FF00}[Анти-паспорт]: {FFFFFF}Выключен!', -1)
	        else 	
	            sampAddChatMessage('{00FF00}[Анти-паспорт]: {FFFFFF}Включен!', -1)
	        end
	    end
    },
	
	{
        title = '{00FF00}Авто ответ: {FFFFFF}Авто ответ на жалобы.',
        onclick = function() bool = not bool 
	        if not bool then 
	            sampAddChatMessage('{00FF00}[Авто ответ]: {FFFFFF}Выключен!', -1)
	        else	
	            sampAddChatMessage('{00FF00}[Авто ответ]: {FFFFFF}Включен!', -1)
	        end
	    end
    },

    {
        title = '{00FF00}Команды: {FFFFFF}Посмотреть админ команды.',
        onclick = function() deff = not deff 
	        sampSendChat('/apanel') 
	    end
    },

    {
        title = '{00FF00}Admins: {FFFFFF}Нажмите для просмотра администраторов в сети.',
        onclick = function() deff = not deff 
			sampSendChat('/admins')  	
	    end
    },

    {
        title = '{00FF00}Реклама: {FFFFFF}Нажмите для того, чтобы написать рекламу на весь сервер.',
        onclick = function() deff = not deff 
	        sampSendChat('/o Где скидки? Правильно! Только у нас и только в /donate')
            sampSendChat('/o Покупай админки по ОГРОМНЫМ скидкам! Действует X2 донат!')
            sampSendChat('/o Только сегодня АКЦИЯ! Покупай 1 лвл админ-панели за 50 рублей!')  
	    end
    },

    {
        title = '{00FF00}Лидеры: {FFFFFF}Нажмите для просмотра списка лидеров.',
        onclick = function() deff = not deff 
	        sampSendChat('/leaders')
	    end
    },

    {
        title = '{00FF00}Хелперы: {FFFFFF}Посмотреть сколько хелперов в сети.',
        onclick = function() deff = not deff 
	        sampSendChat('/helpers')
	    end
    },

    {
        title = '{00FF00}Снять лидера(ов): {FFFFFF}Хочешь снять лидера в оффлайне? Жмякай.',
        onclick = function() deff = not deff 
	        sampSendChat('/checkleaders')
	    end
    },

    {
        title = '{00FF00}Спавн транспорта: {FFFFFF}Заспавнить транспорт на всём сервере.',
        onclick = function() deff = not deff 
	        sampSendChat('/spcars')
	    end
    },

    {
        title = '{00FF00}Спавн транспорта в радиусе: {FFFFFF}Заспавнить транспорт в радиусе "10".',
        onclick = function() deff = not deff 
	        sampSendChat('/spveh 10') 
	    end
    },

    {
        title = '{00FF00}Эфиры: {FFFFFF}Хочешь сделать эфир? Валяй!',
        onclick = function() deff = not deff 
	        sampSendChat('Здравствуйте жители и гости штата.')
            sampSendChat('И сегодня я с вами проведу прогноз погоды')
            sampSendChat('Так и прогноз нам передает что в городах будет...')
            sampSendChat('В г."Los-Santos" 6.2 (С).Вечером будет облачно')  
            sampSendChat('В г."San-Fierro" -10.8 (С).Будет ливень вечером')  
            sampSendChat('А в г."Las-Venturas" 12.2 (С).Весь день будет идти дождь')  
            sampSendChat('А пока на этом все.Спасибо за внимание.Всего хорошего.')
	    end
    },

    {
        title = '{00FF00}Заправить транспорт: {FFFFFF}Заправить транспорт на всём сервере.',
        onclick = function() deff = not deff 
	        sampSendChat('/fuelcars') 
	    end
    },

    {
        title = '{00FF00}Починить машину: {FFFFFF}Починить машину в которой ты сидишь.',
        onclick = function() deff = not deff 
	        sampSendChat('/hp')
	    end
    },

    {
        title = '{00FF00}Предупредить админинов о проверке: {FFFFFF}В админ чат отправиться информация о проверке.',
        onclick = function() deff = not deff 
	        sampSendChat('/a ВНИМАНИЕ АДМИНИСТРАЦИЯ! На данный момент у нас проходит проверка!')
            sampSendChat('/a ВНИМАНИЕ АДМИНИСТРАЦИЯ! На данный момент у нас проходит проверка!') 
            sampSendChat('/a ВНИМАНИЕ АДМИНИСТРАЦИЯ! На данный момент у нас проходит проверка!') 
            sampSendChat('/a ВНИМАНИЕ АДМИНИСТРАЦИЯ! На данный момент у нас проходит проверка!') 
	    end
    },

    {
          title = '{00FF00}Меню МероПриятий{FFFFFF} Открыть	',
        submenu = {
            {
                title = '{00FF00}Создать метку для МП: {FFFFFF}После создания метки можно открывать ТП на МП.',
                onclick = function() deff = not deff 
			        sampSendChat('/mark')	
	                sampAddChatMessage('{00FF00}[Создание метки для ТП на МП]: {FFFFFF}Успешно создана!', -1)
				end
            },
            {
                title = '{00FF00}MenuMP: {FFFFFF}Открыть меню МероПриятий.',
                onclick = function() deff = not deff 
                    sampSendChat('/mp')
				end				
			},
            {
                title = '{00FF00}King of Eagle: {FFFFFF}Провести Король Дигла.',
                onclick = function() deff = not deff 
                    sampShowDialog(1337, "Король Дигла", "Введите приз", "Потвердить", "Закрыть", 1)
	                lua_thread.create(kingofeagle)
				end				
			},
            {
                title = '{00FF00}РР: {FFFFFF}Провести Русскую Рулетку.',
                onclick = function() deff = not deff 
                    sampShowDialog(1338, "Русская Рулетка", "Введите приз", "Потвердить", "Закрыть", 1)
	                lua_thread.create(kingofeagle)
				end				
			},
            {
                title = '{00FF00}Прятки: {FFFFFF}Провести Прятки.',
                onclick = function() deff = not deff 
                    sampShowDialog(1339, "Прятки", "Введите приз", "Потвердить", "Закрыть", 1)
	                lua_thread.create(pryatki)
				end				
			},
		    {
                title = '{00FF00}Race: {FFFFFF}Запустить Гонки на всём сервере.',
                onclick = function() deff = not deff 
	                sampSendChat('/arace')
	            end
            },
		    {
                title = '{00FF00}Race: {FFFFFF}Открыть телепорт на Гонки(Необходимо находится у места регистрации).',
                onclick = function() deff = not deff 
	                sampSendChat('/arace')
					sampSendChat('/o Открываю телепорт на Гонки')
					sampSendChat('/mark')
					sampSendChat('/mp')
	            end
            },
            {
                title = '{00FF00}PaintBall: {FFFFFF}Запустить PaintBall на всём сервере.',
                onclick = function() deff = not deff 
			        sampSendChat('/apaint')
	            end
            },
		    {
                title = '{00FF00}PaintBall: {FFFFFF}Открыть телепорт на PaintBall(Необходимо находится у места регистрации).',
                onclick = function() deff = not deff 
	                sampSendChat('/apaint')
					sampSendChat('/o Открываю телепорт на PaintBall')
					sampSendChat('/mark')
					sampSendChat('/mp')
	            end
            },
			{
                title = '{00FF00}Пиар-рейд: {FFFFFF}Cделать Пиар-Рейд!',
                onclick = function() deff = not deff 
	                sampSendChat('/o Уважаемые игроки, сейчас произойдет пиар-рейд.')
			        sampSendChat('/o Ваша задача пиарить наш cepвep в группах таких как "Diadmond RР" и т.д.')
			        sampSendChat('/o Пиарить cepвeр НЕЛЬЗЯ в группах таких как "Самп-мoнитopинг" и т.д. Призы:')
			        sampSendChat('/o Пять* скриншотов - скин на выбор и 2.000дoната. десять* - 200штук наркотиков.')  
			        sampSendChat('/o Двадцать* - +6 лвл и 3.000доната, тридцать* - хелперка 1 уровня.')  
			        sampSendChat('/o Пятьдесят* хелперка 3 уровня (самый максимальный уровень)')  
			        sampSendChat('/o Скриншоты кидать сюда - vк.соm/erрlifе (*Обязательно напишите свой ник и ник администратора!)')
			        sampSendChat('/o Чтобы попасть на пиар-рейд: /ac mp')
			        sampSendChat('/mark')
			        sampSendChat('/mp')
	            end
            },
        },
    },

{
    title = '{00FF00}Заставить админов работать ( Исключительно для {FF1221}ГА{00FF00} ): {FFFFFF}Заставить админов работать, а не чаи гонять.',
    onclick = function() deff = not deff 
        sampSendChat('/a ВНИМАНИЕ АДМИНИСТРАТОРЫ! РАБОТАЕМ! ПИШЕМ РЕКЛАМУ, ДЕЛАЕМ МП, СТАВИМ ЛИДЕРОВ, ОТВЕЧАЕМ НА РЕПОРТЫ!')
        sampSendChat('/a ВНИМАНИЕ АДМИНИСТРАТОРЫ! РАБОТАЕМ! ПИШЕМ РЕКЛАМУ, ДЕЛАЕМ МП, СТАВИМ ЛИДЕРОВ, ОТВЕЧАЕМ НА РЕПОРТЫ!') 
        sampSendChat('/a ВНИМАНИЕ АДМИНИСТРАТОРЫ! РАБОТАЕМ! ПИШЕМ РЕКЛАМУ, ДЕЛАЕМ МП, СТАВИМ ЛИДЕРОВ, ОТВЕЧАЕМ НА РЕПОРТЫ!') 
        sampSendChat('/a ВНИМАНИЕ АДМИНИСТРАТОРЫ! РАБОТАЕМ! ПИШЕМ РЕКЛАМУ, ДЕЛАЕМ МП, СТАВИМ ЛИДЕРОВ, ОТВЕЧАЕМ НА РЕПОРТЫ!') 
        sampSendChat('/a ВНИМАНИЕ АДМИНИСТРАТОРЫ! РАБОТАЕМ! ПИШЕМ РЕКЛАМУ, ДЕЛАЕМ МП, СТАВИМ ЛИДЕРОВ, ОТВЕЧАЕМ НА РЕПОРТЫ!')
    end
},

{
    title = '{00FF00}Заставить лидеров делать наборы: {FFFFFF}Заставить лидеров и их замов делать наборы и РП.',
    onclick = function() deff = not deff 
        sampSendChat('/o ВНИМАНИЕ! Лидеры и их замы, делайте наборы, проводите РП, игрокам будет веселее и вам интереснее будет играть!')
        sampSendChat('/o ВНИМАНИЕ! Лидеры и их замы, делайте наборы, проводите РП, игрокам будет веселее и вам интереснее будет играть!') 
    end
},

{
      title = '{00FF00}Полезная информация',
    submenu = {
        {
            title = '{FFFFFF}Включи функцию {00FF00}"анти-паспорт" {FFFFFF}чтобы не видеть меню с документами.',	
        },
    },
}, 

}

--МПШКИ
function kingofeagle()
while sampIsDialogActive() do
    wait(0)
    local result, button, list, input = sampHasDialogRespond(1337)
    if result and button == 1 then
        sampSendChat('/o Уважаемые игроки!')
        sampSendChat('/o Сейчас пройдёт МП "Король дигла" ')
        sampSendChat("/o Приз: "..input)
        sampSendChat('/o Чтобы попасть на мп: /ac mp')
        sampSendChat('/o После телепорта сразу в строй!')
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
        sampSendChat('/o Уважаемые игроки!')
        sampSendChat('/o Сейчас пройдёт МП "Русская Рулетка" ')
        sampSendChat("/o Приз: "..input)
        sampSendChat('/o Чтобы попасть на мп: /ac mp')
        sampSendChat('/o После телепорта сразу в строй!')
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
            sampSendChat('/o Уважаемые игроки!')
            sampSendChat('/o Сейчас пройдёт МП "Прятки" ')
            sampSendChat("/o Приз: "..input)
            sampSendChat('/o Чтобы попасть на мп: /ac mp')
            sampSendChat('/o После телепорта сразу в строй!')
            sampSendChat('/mark')
            sampSendChat('/mp')
        end
    end
    end	
--мпшки



function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	    sampAddChatMessage('{00FF00}[Admin Panel ETRP]: {FFFFFF}Плагин успешно загружен! {00FF00}(By Vollar. Edited by Kohan)', -1)
		thr1 = lua_thread.create_suspended(SpawnCarInPoint)
	sampRegisterChatCommand("nop", function() nop = not nop 
	--	if not nop then 
	--	sampAddChatMessage('{00FF00}[Nop]: {FFFFFF}!', -1)
	--	else
	--	sampAddChatMessage('{00FF00}[Nop]: {FFFFFF}!', -1)
	--	end
	end) 

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("{00FF00}[Admin Panel ETRP]: {ff0000}Доступно обновление: {FFFFFF}Новая версия: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end             
    end)
    
	sampRegisterChatCommand('etp', function() power = not power
		if not power then 
		    sampAddChatMessage('{00FF00}[ETeleport]: {FFFFFF}Выключен!', -1)
		else
		    sampAddChatMessage('{00FF00}[ETeleport]: {FFFFFF}Включен!', -1)
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
                    sampAddChatMessage("{00FF00}[Admin Panel ETRP]{FFFFFF}: Успешно обновился! Начинаю перезагрузку скрипта", -1)
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
			sampAddChatMessage('{FF33CC}[SpawnCarInPoint]: {FFFFFF}Вы вышли из авто, скрипт выключен!', -1)
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
			else sampAddChatMessage('{FF33CC}[ETeleport]: {FFFFFF}Поставьте метку на карте для телепорта.', -1)
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
    if text:find("Игрок далеко от вас.") then 
	    return false
    elseif text:find("Демонстрация") then
        return false
    elseif text:find("Игрок не найден") then
        return false
	elseif text:find("Не флуди!") then
        return false	
    end
	
	if bool then 		
	    if text:find("%[Жалоба%] от ") or text:find("%[Вопрос%] от ") then
		   if text:match('%[(%d+)%]: (.*)') then
			    id, other = text:match('%[(%d+)%]: (.*)')
				lua_thread.create(function() 
			        wait(1000)
				    sampSendChat('/pm '..id..' Здравствуйте! Начинаю работать по вашей жалобе! Желаю приятной игры на проекте!') 
                end)
            end
        end
    end
	
	if state then 
	    if text:find("Внимание!!Администратор запустил конкурс на админ панель!!!") then
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
    if c:find("Выбор документа") and isKeyDown(VK_RBUTTON) then
        return false
	elseif c:find("Passport") and deff then
        return false
    end	

    if vkl then
        if j:find("Выписка из тира") then
		    sampAddChatMessage('{FF33CC}[AChecker]: {FFFFFF}За вами следит Администратор!' , -1)
			sampAddChatMessage('{FF33CC}[AChecker]: {FFFFFF}Зайти в режим {FF33CC}NO RECON{FFFFFF}, нажмите {FF33CC}J', -1)
			sampAddChatMessage('{FF33CC}[AChecker]: {FFFFFF}Выйти из режима {FF33CC}NO RECON{FFFFFF}, нажмите {FF33CC}L', -1)
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
    select_button, close_button, back_button = select_button or 'Выбрать', close_button or 'Закрыть', back_button or 'Назад'
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