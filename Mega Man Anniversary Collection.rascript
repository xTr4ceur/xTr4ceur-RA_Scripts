// Mega Man Anniversary Collection
// #ID = 19238
///////////////////////////////////////
//                                   //
// Script made by xTr4ceur           //
//                                   //
// last change: 09/10/2022 1:20 pm   //
//                                   //
///////////////////////////////////////



////////////////////////////////////
// Global Variables               //
////////////////////////////////////

mmVersion = [
    "[MM I] ",
    "[MM II] ",
    "[MM III] ",
    "[MM IV] ",
    "[MM V] ",
    "[MM VI] ",
    "[MM VII] ",
    "[MM VIII] ",
    "[MM TBW] ",
    "[MM 2 TPW] " 
]


////////////////////////////////////
// Global Addresses               //
////////////////////////////////////

// Actual selected Game
actGame = byte(0x16e488)

// Digital Pad (Face buttons Left)
ctrlDPadLeft = bit7(0x16e611)
ctrlDPadRight = bit5(0x16e611)
ctrlDPadUp = bit4(0x16e611)
ctrlDPadDown = bit6(0x16e611)

// Face Buttons Right
ctrlCross = bit6(0x16e610)
ctrlCircle = bit5(0x16e610)
ctrlTriangle = bit4(0x16e610)
ctrlSquare = bit7(0x16e610)

// Bumper + Trigger
ctrlLeftBump = bit2(0x16e610)
ctrlRightBump = bit3(0x16e610)
ctrlLeftTrig = bit0(0x16e610)
ctrlRightTrig = bit1(0x16e610)

// Start + Select
ctrlStart = bit3(0x16e611)
ctrlSelect = bit0(0x16e611)


/////////////////////////////
// Description write functions
/////////////////////////////////////

// *    Stage Clear Achievements
function StageClearDescription(counter, bossNameList){
    actDesc = "Beat " + bossNameList[counter]
    return actDesc
}

// *    Mega Buster Only Achievement
function MgBustDesc(counter, bossNameList){
    actDesc = "Beat" + bossNameList[counter] + " with Mega Buster only"
    return actDesc
}


// *    Damageless Boss Achievement
function DmgsBsDesc(counter, bossNameList){
    actDesc = "Beat " + bossNameList[counter] + " without being harmed"
    return actDesc
}


////////////////////////
// Achievement functions
/////////////////////////////////////

// *    Stage Clear Achievement
function StageClearCheevo(
                        counter,                     
                        selectedGame,                     
                        stageID, screenID, startScreenID,
                        megaManRespawnFlag, selectedRespawnFlag, 
                        bossNameList, bossHP, bossHPDead, bossState, bossDefeatValue, bossScreen
                    ){                      
    achievement(
        title = mmVersion[0] + bossNameList[counter],
        description = StageClearDescription(counter, bossNameList), 
        points = 1,
        trigger = 
            never(ctrlSelect > prev(ctrlSelect)) &&
            tally(1, actGame == selectedGame && stageID == counter && screenID == startScreenID && megaManRespawnFlag == selectedRespawnFlag) &&            
            screenID == bossScreen[counter] &&            
            bossHP == bossHPDead &&
            bossState == bossDefeatValue
    )
}


// *    Mega Buster Only Achievement
function MgBustChev(actStgID, bNL, bDV){
    achievement(    
        title = mmVersion[0] + "Mega Buster " + bNL[actStgID],
        description = MgBustDesc(actStgID, bNL),
        points = 1,
        trigger = 
            never(ctrlSelect > prev(ctrlSelect)) &&
            actGame == 0x01 &&             
            tally(1, (mm1StageID == actStgID && prev(mm1StageScreenID) == mm1BossScreen[actStgID] - 1 && mm1StageScreenID == mm1BossScreen[actStgID])) &&
            repeated(0, (mm1BossHP == 0x00 && trigger_when(mm1BossState == bDV)))&& (            
                never(mm1CutManShot < prev(mm1CutManShot)) &&                
                never(mm1IceManShot < prev(mm1IceManShot)) &&
                never(mm1BombManShot < prev(mm1BombManShot)) &&
                never(mm1FireManShot < prev(mm1FireManShot)) &&
                never(mm1ElecManShot < prev(mm1ElecManShot)) &&
                never(mm1GutsManShot < prev(mm1GutsManShot)) &&
                never(mm1MagnetBeam < prev(mm1MagnetBeam)) ||
                always_false()
            )
    )
}


// *    Damageless Boss Achievement
function DmgsBsChev(actStgID, bNL, bDV){
    achievement(
        title = mmVersion[0] + "Damageless " + bNL[actStgID],    
        description = DmgsBsDesc(actStgID, bNL), 
        points = 1,
        trigger = 
            never(ctrlSelect > prev(ctrlSelect)) &&
            never(mm1PlayerHP < prev(mm1PlayerHP)) &&
            actGame == 0x01 &&             
            tally(1, (mm1StageID == actStgID && prev(mm1StageScreenID) == mm1BossScreen[actStgID] - 1 && mm1StageScreenID == mm1BossScreen[actStgID])) &&
            repeated(0, (mm1BossHP == 0x00 && trigger_when(mm1BossState == bDV)))            
    )
}


////////////////////////////////////////////////
//                                            //
//          Mega Man I - Achievements         //
//                                            //
////////////////////////////////////////////////
//  Boss            StageID     StageScreenID //
//                              (BossRoom)    //
//--------------------------------------------//
//  Cut Man         0x00        0x17          //
//  Ice Man         0x01        0x17          //
//  Bomb Man        0x02        0x17          //
//  Fire Man        0x03        0x13          //
//  Elec Man        0x04        0x17          //
//  Guts Man        0x05        0x12          //
//  Yellow Devil    0x06        0x27          //
//  Copy Robot      0x07        0x29          //
//  CWU-01P         0x08        0x2f          //
//  Wily Machine #1 0x09        0x23          //
////////////////////////////////////////////////


////////////
// MM1 - Variables
/////////////////////////////////////

mm1BossNames = [
    "Cut Man", 
    "Ice Man", 
    "Bomb Man", 
    "Fire Man", 
    "Elec Man", 
    "Guts Man", 
    "Yellow Devil", 
    "Copy Robot", 
    "CWU-01P", 
    "Wily Machine #1"
]              
mm1BossDefeatValue = [
    0x0d,   // Wily beaten
    0x0f    // Boss beaten/Boss Item collected
] 
mm1BossStartScreenID = [
    0x00,   // Robot Master Stages
    0x18,   // Wily Stage 1 - 3
    0x14    // Final Wily Stage
]
mm1BossScreen = [
    0x17,   // Cut Man
    0x17,   // Ice Man
    0x17,   // Bomb Man
    0x13,   // Fire Man
    0x17,   // Elec Man
    0x12,   // Guts Man
    0x27,   // Yellow Devil
    0x29,   // Copy Robot
    0x2f,   // CWU-01P
    0x23    // Wily Machine #1
]
mm1BossRange = length(mm1BossNames) - 1


////////////
// MM1 - Addresses
/////////////////////////////////////

// *    Game Info -> Variable
mm1RespawnFlg = byte(0x1c11256)
mm1StageID = byte(0x2000ac9)
mm1StageScreenID = byte(0xb61fb8)
mm1PlayerHP = byte(0x2000b02)
mm1PlayerLife = byte(0x2000b3e)
mm1BossHP = byte(0xb62219)
mm1BossState = byte(0x19a428)

// *    Weapon Quanitity -> Variable
mm1CutManShot = byte(0x2000b03)
mm1IceManShot = byte(0x2000b04)
mm1BombManShot = byte(0x2000b05)
mm1FireManShot = byte(0x2000b06)
mm1ElecManShot = byte(0x2000b07)
mm1GutsManShot = byte(0x2000b08)
mm1MagnetBeam = byte(0x2000b09)


/////////////
// MM1 - CALL
/////////////////////////////////////

for counter in range(0, mm1BossRange){
    if(counter == mm1BossRange){            // Dr. Wily - Final Stage   
        StageClearCheevo(
            counter, 
            0x01, 
            mm1StageID, mm1StageScreenID, 
            mm1BossStartScreenID[2], mm1RespawnFlg, 
            0xf0, mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[0], mm1BossScreen
        )
        MgBustChev(counter, mm1BossNames, mm1BossDefeatValue[0]) 
        DmgsBsChev(counter, mm1BossNames, mm1BossDefeatValue[0])  
    } 
    else{    
        if(counter >= 0 && counter <= 5){   // Robot Master Stages
            StageClearCheevo(
                counter, 
                0x01, 
                mm1StageID, mm1StageScreenID, 
                mm1BossStartScreenID[0], mm1RespawnFlg, 
                0xf0, mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[1], mm1BossScreen
            )
        }   
        else{                               // Dr. Wily - Stage 1-3
            StageClearCheevo(
                counter, 
                0x01, 
                mm1StageID, mm1StageScreenID, 
                mm1BossStartScreenID[1], mm1RespawnFlg, 
                0xf0, mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[0], mm1BossScreen
            )
        }        
        MgBustChev(counter, mm1BossNames, mm1BossDefeatValue[1]) 
        DmgsBsChev(counter, mm1BossNames, mm1BossDefeatValue[1])
    }       
}


////////////////////////////////////////////////
//                                            //
//          Mega Man II - Achievements        //
//                                            //
////////////////////////////////////////////////


/////////////////////////////
// MM2 - Description write function
/////////////////////////////////////


/////////////
// MM2 - CALL
/////////////////////////////////////


////////////////////////////////////////////////
//                                            //
//          Mega Man III - Achievements       //
//                                            //
////////////////////////////////////////////////

////////////////////////////////////////////////
//                                            //
//          Mega Man IV - Achievements        //
//                                            //
////////////////////////////////////////////////

////////////////////////////////////////////////
//                                            //
//          Mega Man V - Achievements         //
//                                            //
////////////////////////////////////////////////

////////////////////////////////////////////////
//                                            //
//          Mega Man VI - Achievements        //
//                                            //
////////////////////////////////////////////////

////////////////////////////////////////////////
//                                            //
//          Mega Man VII - Achievements       //
//                                            //
////////////////////////////////////////////////

////////////////////////////////////////////////
//                                            //
//          Mega Man VIII - Achievements      //
//                                            //
////////////////////////////////////////////////

////////////////////////////////////////////////
//                                            //
//          Mega Man TPW - Achievements       //
//                                            //
////////////////////////////////////////////////

////////////////////////////////////////////////
//                                            //
//          Mega Man 2 TPW - Achievements     //
//                                            //
////////////////////////////////////////////////