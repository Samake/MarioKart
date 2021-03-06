local objectID = 15050
local maxObjects = 8
local lodDistance = 300

addEventHandler("onClientResourceStart", resourceRoot, 
function(resource)
	if (resource == getThisResource()) then
		for i = 1, maxObjects do
			objectTexture = engineLoadTXD("models/luigi.txd")
			objectModel = engineLoadDFF("models/luigi" .. i .. ".dff", objectID + i)
			objectCol = engineLoadCOL("models/luigi" .. i .. ".col")
			
			engineImportTXD(objectTexture, objectID + i)
			engineReplaceModel(objectModel, objectID + i)
			engineReplaceCOL(objectCol, objectID + i)
			
			if (not objectTexture) then
				outputChatBox("Load texture " .. i .. " failed!")
			end
			
			if (not objectModel) then
				outputChatBox("Load model " .. i .. " failed!")
			end
			
			if (not objectCol) then
				outputChatBox("Load col " .. i .. " failed!")
			end
		end

		for i, object in pairs(getElementsByType("object")) do
			if isElement(object) then
				for j = objectID, objectID + maxObjects, 1 do
					if (getElementModel(object) == j) then
						local lodX, lodY, lodZ = getElementPosition(object)
						local lodRX, lodRY, lodRZ = getElementRotation(object) 
						local lodObject = createObject(j, lodX, lodY, lodZ, lodRX, lodRY, lodRZ, true)
						setLowLODElement(object, lodObject)
						engineSetModelLODDistance(j, lodDistance)
						setElementDoubleSided(object, true)
					end
				end
			end
		end
		
		local sound = playSound("sounds/luigi_circuit.ogg", true)
		
		if (sound) then
			setSoundVolume(sound, 0.5)
		end
	end
end)