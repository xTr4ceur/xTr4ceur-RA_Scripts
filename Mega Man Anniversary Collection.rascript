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
                        counter,                     
                        selectedGame,                     
                        stageID, screenID, startScreenID,
                        megaManRespawnFlag, selectedRespawnFlag, 
                        bossNameList, bossHP, bossHPDead, bossState, bossDefeatValue, bossScreen
                    ){                      
    achievement(
        title = megaManVersion[selectedGame - 1] + bossNameList[counter],
        description = StageClearDescription(counter, bossNameList), 
        points = 1,
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
            points = 1,
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
            points = 1,
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
                        never(weaponQuantity[8] < prev(weaponQuantity[8])) ||
                        always_false()        
                )
        ) 
    }
    
}


// *    Damageless Boss Achievement
function DamagelesssBossCheevo(
                        counter,                           
                        selectedGame,                          
                        stageID, screenID,  
                        megaManHP,
                        bossNameList, bossHP, bossHPDead, bossState, bossDefeatValue, bossScreen
                    ){
    achievement(
        title = megaManVersion[selectedGame - 1] + "Damageless " + bossNameList[counter],    
        description = DamagelessBossDescription(counter, bossNameList), 
        points = 1,
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
            counter, 
            0x01, 
            mm1StageID, mm1StageScreenID, 
            mm1BossStartScreenID[2], mm1RespawnFlg, 0xf0, 
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[0], mm1BossScreen
        )
        MegaBusterCheevo(
            counter, 
            0x01,
            mm1StageID, mm1StageScreenID,
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[0], mm1BossScreen,
            mm1Weapon
        )
        DamagelesssBossCheevo(
            counter,            
            0x01,
            mm1StageID, mm1StageScreenID,
            mm1PlayerHP,
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[0], mm1BossScreen
        )  
    } 
// *    Robot Master Stages
    else{    
        if(counter >= 0 && counter <= 5){
            StageClearCheevo(
                counter, 
                0x01, 
                mm1StageID, mm1StageScreenID, 
                mm1BossStartScreenID[0], mm1RespawnFlg, 
                0xf0, mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[1], mm1BossScreen
            )
        }
// *    Dr. Wily - Stage 1-3
        else{                               
            StageClearCheevo(
                counter, 
                0x01, 
                mm1StageID, mm1StageScreenID, 
                mm1BossStartScreenID[1], mm1RespawnFlg, 
                0xf0, mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[0], mm1BossScreen
            )
        }        
        MegaBusterCheevo(
            counter, 
            0x01,
            mm1StageID, mm1StageScreenID,
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[1], mm1BossScreen,
            mm1Weapon
        ) 
        DamagelesssBossCheevo(
            counter, 
            0x01,
            mm1StageID, mm1StageScreenID,
            mm1PlayerHP,
            mm1BossNames, mm1BossHP, 0x00, mm1BossState, mm1BossDefeatValue[1], mm1BossScreen
        )
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