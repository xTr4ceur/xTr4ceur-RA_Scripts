// Mega Man Anniversary Collection
// #ID = 19238
///////////////////////////////////////
//                                   //
// Script made by xTr4ceur           //
//                                   //
// last change: 09/10/2022 2:52 pm   //
//                                   //
///////////////////////////////////////



////////////////////////////////////
// Global Variables               //
////////////////////////////////////

megaManVersion = [
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
actualGame = byte(0x16e488)


control = {
    // Digital Pad (Face buttons Left)
    "Left": bit7(0x16e611),
    "Right": bit5(0x16e611),
    "Up": bit4(0x16e611),
    "Down": bit6(0x16e611),
     
    // Face Buttons Right
    "Cross": bit6(0x16e610),
    "Circle": bit5(0x16e610),
    "Triangle": bit4(0x16e610),
    "Square": bit7(0x16e610),

    // Bumper + Trigger
    "Left Bumper": bit2(0x16e610),
    "Right Bumper": bit3(0x16e610),
    "Left Trigger": bit0(0x16e610),
    "Right Trigger": bit1(0x16e610),

    // Start + Select
    "Start": bit3(0x16e611),
    "Select": bit0(0x16e611)   
}


/////////////////////////////
// Description write functions
/////////////////////////////////////

// *    Stage Clear Achievements
function StageClearDescription(counter, bossNameList){
    actDesc = "Beat " + bossNameList[counter]
    return actDesc
}

// *    Mega Buster Only Achievement
function MegaBusterDescription(counter, bossNameList){
    actDesc = "Beat" + bossNameList[counter] + " with Mega Buster only"
    return actDesc
}


// *    Damageless Boss Achievement
function DamagelessBossDescription(counter, bossNameList){
    actDesc = "Beat " + bossNameList[counter] + " without being harmed"
    return actDesc
}


////////////////////////
// Achievement functions
/////////////////////////////////////

// *    Stage Clear Achievement
function StageClearCheevo(
                        cheevoPoints,
                        counter,                     
                        selectedGame,                     
                        stageID, screenID, startScreenID,
                        megaManRespawnFlag, selectedRespawnFlag, 
                        bossNameList, bossHP, bossHPDead, bossState, bossDefeatValue, bossScreen
                    ){                      
    achievement(
        title = megaManVersion[selectedGame - 1] + bossNameList[counter],
        description = StageClearDescription(counter, bossNameList), 
        points = cheevoPoints,
        trigger = 
            never(control["Select"] > prev(control["Select"])) &&
            tally(1, actualGame == selectedGame && stageID == counter && screenID == startScreenID && megaManRespawnFlag == selectedRespawnFlag) &&            
            screenID == bossScreen[counter] &&            
            bossHP == bossHPDead &&
            bossState == bossDefeatValue
    )
    
}


// *    Mega Buster Achievement
function MegaBusterCheevo(
                        cheevoPoints,
                        counter,                           
                        selectedGame,                          
                        stageID, screenID,                         
                        bossNameList, bossHP, bossHPDead, bossState, bossDefeatValue, bossScreen,                        
                        weaponQuantity
                    ){ 
    if(selectedGame == 0x01){
        achievement(    
            title = megaManVersion[selectedGame - 1] + "Mega Buster " + bossNameList[counter],
            description = MegaBusterDescription(counter, bossNameList),
            points = cheevoPoints,
            trigger =         
                never(control["Select"] > prev(control["Select"])) &&
                actualGame == selectedGame &&             
                tally(1, (stageID == counter && prev(screenID) == bossScreen[counter] - 1 && screenID == bossScreen[counter])) &&
                repeated(0, (bossHP == bossHPDead && trigger_when(bossState == bossDefeatValue)))&& (        
                        never(weaponQuantity[0] < prev(weaponQuantity[0])) &&                
                        never(weaponQuantity[1] < prev(weaponQuantity[1])) &&
                        never(weaponQuantity[2] < prev(weaponQuantity[2])) &&
                        never(weaponQuantity[3] < prev(weaponQuantity[3])) &&
                        never(weaponQuantity[4] < prev(weaponQuantity[4])) &&
                        never(weaponQuantity[5] < prev(weaponQuantity[5])) &&
                        never(weaponQuantity[6] < prev(weaponQuantity[6])) || 
                        always_false()        
                )
        )  
    }
    else if(selectedGame > 0x01){
       achievement(    
            title = megaManVersion[selectedGame - 1] + "Mega Buster " + bossNameList[counter],
            description = MegaBusterDescription(counter, bossNameList),
            points = cheevoPoints,
            trigger =         
                never(control["Select"] > prev(control["Select"])) &&
                actualGame == selectedGame &&             
                tally(1, (stageID == counter && prev(screenID) == bossScreen[counter] - 1 && screenID == bossScreen[counter])) &&
                repeated(0, (bossHP == bossHPDead && trigger_when(bossState == bossDefeatValue)))&& (        
                        never(weaponQuantity[0] < prev(weaponQuantity[0])) &&                
                        never(weaponQuantity[1] < prev(weaponQuantity[1])) &&
                        never(weaponQuantity[2] < prev(weaponQuantity[2])) &&
                        never(weaponQuantity[3] < prev(weaponQuantity[3])) &&
                        never(weaponQuantity[4] < prev(weaponQuantity[4])) &&
                        never(weaponQuantity[5] < prev(weaponQuantity[5])) &&
                        never(weaponQuantity[6] < prev(weaponQuantity[6])) &&
                        never(weaponQuantity[7] < prev(weaponQuantity[7])) &&
                        never(weaponQuantity[8] < prev(weaponQuantity[8])) &&
                        never(weaponQuantity[9] < prev(weaponQuantity[9])) &&
                        never(weaponQuantity[10] < prev(weaponQuantity[10])) &&
                        never(weaponQuantity[11] != prev(weaponQuantity[11])) ||
                        always_false()        
                )
        ) 
    }
    
}


// *    Damageless Boss Achievement
function DamagelesssBossCheevo(
                        cheevoPoints,
                        counter,                           
                        selectedGame,                          
                        stageID, screenID,  
                        megaManHP,
                        bossNameList, bossHP, bossHPDead, bossState, bossDefeatValue, bossScreen
                    ){
    achievement(
        title = megaManVersion[selectedGame - 1] + "Damageless " + bossNameList[counter],    
        description = DamagelessBossDescription(counter, bossNameList), 
        points = cheevoPoints,
        trigger = 
            never(control["Select"] > prev(control["Select"])) &&
            never(megaManHP < prev(megaManHP)) &&
            actualGame == selectedGame &&             
            tally(1, (stageID == counter && prev(screenID) == bossScreen[counter] - 1 && screenID == bossScreen[counter])) &&
            repeated(0, (bossHP == bossHPDead && trigger_when(bossState == bossDefeatValue)))            
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
mm1BossDefeatValue = {
    "Wily": 0x0d,
    "Boss beaten": 0x0f
}
mm1StartScreenID = {
    "Robot Master": 0x00,
    "Pre Wily": 0x18,
    "Wily": 0x14
}
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
mm1Weapon = [
    byte(0x2000b03),    // Cut Man
    byte(0x2000b04),    // Ice Man
    byte(0x2000b05),    // Bomb Man
    byte(0x2000b06),    // Fire Man
    byte(0x2000b07),    // Elec Man
    byte(0x2000b08),    // Guts Man
    byte(0x2000b09)     // Magnet Beam
]


/////////////
// MM1 - CALL
/////////////////////////////////////

for counter in range(0, mm1BossRange){
// *    Dr. Wily - Final Stage 
    if(counter == mm1BossRange){    
        StageClearCheevo(
            10,
            counter, 
            0x01, 
            mm1StageID, mm1StageScreenID, mm1StartScreenID["Wily"], 
            mm1RespawnFlg, 0xf0, 
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue["Wily"], mm1BossScreen
        )
        MegaBusterCheevo(
            10,
            counter, 
            0x01,
            mm1StageID, mm1StageScreenID,
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue["Wily"], mm1BossScreen,
            mm1Weapon
        )
        DamagelesssBossCheevo(
            25,
            counter,            
            0x01,
            mm1StageID, mm1StageScreenID,
            mm1PlayerHP,
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue["Wily"], mm1BossScreen
        )  
    } 
// *    Robot Master Stages
    else{    
        if(counter >= 0 && counter <= 5){
            StageClearCheevo(
                5,
                counter, 
                0x01, 
                mm1StageID, mm1StageScreenID, mm1StartScreenID["Robot Master"], 
                mm1RespawnFlg, 0xf0, 
                mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue["Boss beaten"], mm1BossScreen
            )
        }
// *    Dr. Wily - Stage 1-3
        else{                               
            StageClearCheevo(
                5,
                counter, 
                0x01, 
                mm1StageID, mm1StageScreenID, mm1StartScreenID["Pre Wily"], 
                mm1RespawnFlg, 0xf0, 
                mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue["Boss beaten"], mm1BossScreen
            )
        }        
        MegaBusterCheevo(
            10,
            counter, 
            0x01,
            mm1StageID, mm1StageScreenID,
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue["Boss beaten"], mm1BossScreen,
            mm1Weapon
        ) 
        DamagelesssBossCheevo(
            10,
            counter, 
            0x01,
            mm1StageID, mm1StageScreenID,
            mm1PlayerHP,
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue["Boss beaten"], mm1BossScreen
        )
    }       
}


////////////////////////////////////////////////
//                                            //
//          Mega Man II - Achievements        //
//                                            //
////////////////////////////////////////////////


////////////
// MM2 - Variables
/////////////////////////////////////

mm2BossNames = [//
    "Heat Man", 
    "Air Man", 
    "Wood Man", 
    "Bubble Man", 
    "Quick Man", 
    "Flash Man", 
    "Metal Man", 
    "Crash Man", 
    "Mecha Dragon", 
    "Picopico-Kun",
    "Guts Tank",
    "Boobeam Trap",
    "Wily Machine #2",
    "Alien"
]
mm2StartScreenID = {
    "Robot Master": 0x00,
    "Wily Stage 1-3, 5": 0x18,    
    "Wily Stage 4, 6": 0x16
}
mm2BossScreen = [
    0x17,   // Heat Man
    0x15,   // Air Man
    0x17,   // Wood Man
    0x15,   // Bubble Man
    0x17,   // Quick Man
    0x13,   // Flash Man
    0x15,   // Metal Man
    0x13,   // Crash Man
    0x2a,   // Mecha Dragon
    0x27,   // Picopico-Kun
    0x27,   // Guts Tank
    0x26,   // Boobeam Trap
    0x29,   // Wily Machine #2
    0x1f    // Alien
]
mm2BossRange = length(mm2BossNames) - 1


////////////
// MM2 - Addresses
/////////////////////////////////////

// *    Game Info -> Variable
mm2RespawnFlg = byte(0x1b64c9f)
mm2StageID = byte(0xaed15c)
mm2StageScreenID = byte(0xb61f98)
mm2PlayerHP = byte(0xb62218)
mm2PlayerLife = byte(0x2000b40)
mm2BossHP = byte(0xb62219)
mm2BossState = byte(0x2000b55)

// *    Weapon Quanitity -> Variable
mm2Weapon = [
    byte(0x2000b34),   // Heat Man
    byte(0x2000b35),   // Air Man
    byte(0x2000b36),   // Wood Man
    byte(0x2000b37),   // Bubble Man
    byte(0x2000b38),   // Quick Man
    byte(0x2000b39),   // Flash Man
    byte(0x2000b3a),   // Metal Man
    byte(0x2000b3b),   // Crash Man
    byte(0x2000b3c),   // Item-1
    byte(0x2000b3d),   // Item-2
    byte(0x2000b3e),   // Item-3
    byte(0x2000b44)    // Weapon Buffer
]


/////////////
// MM2 - CALL
/////////////////////////////////////

for counter in range(0, mm2BossRange){
// *    Dr. Wily - Stage 4 and Final
    if(counter == mm2BossRange){    
        StageClearCheevo(        
            10,
            counter, 
            0x02, 
            mm2StageID, mm2StageScreenID, mm2StartScreenID["Wily Stage 4, 6"], 
            mm2RespawnFlg, 0x80, 
            mm2BossNames, mm2BossHP, 0x00, mm2BossState, 0x01, mm2BossScreen
        )
        MegaBusterCheevo(
            10,
            counter, 
            0x02,
            mm2StageID, mm2StageScreenID,
            mm2BossNames, mm2BossHP, 0x00, mm2BossState, 0x01, mm2BossScreen,
            mm2Weapon
        )
        DamagelesssBossCheevo(
            25,
            counter,            
            0x02,
            mm2StageID, mm2StageScreenID,
            mm2PlayerHP,
            mm2BossNames, mm2BossHP, 0x00, mm2BossState, 0x01, mm2BossScreen
        )  
    } 
// *    Robot Master Stages
    else{    
        if(counter >= 0 && counter <= 7){
            StageClearCheevo(
                5,
                counter, 
                0x02, 
                mm2StageID, mm2StageScreenID, mm2StartScreenID["Robot Master"], 
                mm2RespawnFlg, 0x80, 
                mm2BossNames, mm2BossHP, 0x00, mm2BossState, 0x01, mm2BossScreen
            )
        }
// *    Dr. Wily - Stage 1-3 and 5
        else{            
            StageClearCheevo(
                5,
                counter, 
                0x02, 
                mm2StageID, mm1StageScreenID, mm2StartScreenID["Wily Stage 1-3, 5"], 
                mm2RespawnFlg, 0x80, 
                mm2BossNames, mm2BossHP, 0x00, mm2BossState, 0x01, mm2BossScreen
            )
        }        
        MegaBusterCheevo(
            10,
            counter, 
            0x02,
            mm2StageID, mm2StageScreenID,
            mm2BossNames, mm2BossHP, 0x00, mm2BossState, 0x01, mm2BossScreen,
            mm2Weapon
        ) 
        DamagelesssBossCheevo(
            10,
            counter, 
            0x02,
            mm2StageID, mm2StageScreenID,
            mm2PlayerHP,
            mm2BossNames, mm2BossHP, 0x00, mm2BossState, 0x01, mm2BossScreen
        )
    }       
}


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