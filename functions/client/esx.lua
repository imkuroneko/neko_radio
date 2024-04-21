if GetResourceState('es_extended') ~= 'started' then return end
local ESX = exports['es_extended']:getSharedObject()

function GetAccessInfo(frequency)
    local jobName = ESX.GetPlayerData().job.name

    if Config.restrictedForJobs[frequency] ~= nil then
        HasRequiredJob = false
        UserOnDuty = false

        for key, name in pairs(Config.restrictedForJobs[frequency]) do
            if jobName == name then
                HasRequiredJob = true
                UserOnDuty = true
            end
            if jobName == 'off'..name then
                HasRequiredJob = true
            end
        end

        return { jobChannel = true, hasJob = HasRequiredJob, onDuty = UserOnDuty }
    else
        return { jobChannel = false }
    end
end

