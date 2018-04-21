
--
-- When initiative is changed, update effects "init" value
--
--

function onInit()
    CombatManager.addCombatantFieldChangeHandler("initresult", "onUpdate", updateForInitiative);
end

-- when player's initiative changes we run this to update effect for new "initiative" if it's not 0
function updateForInitiative(nodeField)
  local nodeCT = nodeField.getParent();
  local nInitResult = DB.getValue(nodeCT,"initresult",0);
  for _,nodeEffect in pairs(DB.getChildren(nodeCT, "effects")) do
    local nInit = DB.getValue(nodeEffect,"init",0);
    Debug.console("manager_effect_adnd.lua","updateForInitiative","nodeEffect",nodeEffect);
    if (nInit ~= 0 and nInit ~= nInitResult) then 
      -- change effect init to the new value rolled
      DB.setValue(nodeEffect,"init","number", nInitResult);
    end
  end
end
