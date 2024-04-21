if GetResourceState('qb-core') ~= 'started' then return end
local QBCore = exports['qb-core']:GetCoreObject()

function GetAccessInfo(frequency)
    local job = QBCore.Functions.GetPlayerData().job

    if Config.restrictedForJobs[frequency] ~= nil then
        HasRequiredJob = false
        for key, name in pairs(Config.restrictedForJobs[frequency]) do
            if job.name == name then HasRequiredJob = true end
        end

        return { jobChannel = true, hasJob = HasRequiredJob, onDuty = job.onduty }
    else
        return { jobChannel = false }
    end
end