// Mega Man Anniversary Collection
// #ID = 19238
///////////////////////////////////////
//                                   //
// Script made by xTr4ceur           //
//                                   //
// last change: 02/01/2023 22:09 pm  //
//                                   //
///////////////////////////////////////


////////////////////////////////////
// Global Variables               //
////////////////////////////////////

Gv_megaManValues = {
    0x00: {"Version":"[MM I] ", "GameID":0x00},
    0x01: {"Version":"[MM II] ", "GameID":0x01},
    0x02: {"Version":"[MM III] ", "GameID":0x02},
    0x03: {"Version":"[MM IV] ", "GameID":0x03},
    0x04: {"Version":"[MM V] ", "GameID":0x04},
    0x05: {"Version":"[MM VI] ", "GameID":0x05},
    0x06: {"Version":"[MM VII] ", "GameID":0x06},
    0x07: {"Version":"[MM 8] ", "GameID":0x07},
    0x08: {"Version":"[MM TPB] ", "GameID":0x08},
    0x09: {"Version":"[MM 2 TPF] ", "GameID":0x09} 
}

Gv_romanNumbers = [
    "I",
    "II",
    "III",
    "IV",
    "V",
    "VI",
    "VII",
    "VIII",
    "IX",
    "X"
]


////////////////////////////////////
// Global Addresses               //
////////////////////////////////////

// Actual selected Game
Ga_actualGame = byte(0x20a834)

Ga_control = {
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
                        bossName, bossHP, bossHPDead, bossState, bossDefeatValue, bossScreen
                    ){                      
    achievement(      
        title = Gv_megaManValues[selectedGame]["Version"] + bossName,          
        description = "Beat " + bossName, 
        points = cheevoPoints,
        trigger = 
            never(Ga_control["Select"] > prev(Ga_control["Select"])) &&            
            never(Ga_actualGame != selectedGame) && 
            never(stageID != counter) &&
            tally(1, screenID == startScreenID && megaManRespawnFlag == selectedRespawnFlag) &&            
            screenID == bossScreen &&            
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
                        bossName, bossHP, bossHPDead, bossState, bossDefeatValue, bossScreen,                        
                        weaponQuantity, playerLife
                    ){                     
    if(selectedGame == 0x00){
        achievement(    
            title = Gv_megaManValues[selectedGame]["Version"] + "Buster Master: " + bossName,
            description = "Beat " + bossName + " with Mega Buster only",
            points = cheevoPoints,
            trigger =   
                never(Ga_actualGame != selectedGame) &&
                never(stageID != counter) && 
                tally(1, (prev(screenID) == bossScreen - 1 && screenID == bossScreen)) &&
                repeated(0, (bossHP == bossHPDead && trigger_when(bossState == bossDefeatValue))) && 
                (     
                        never(Ga_control["Select"] > prev(Ga_control["Select"])) &&
                        never(prev(playerLife) > playerLife) &&
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
    else if(selectedGame > 0x00){
       achievement(    
            title = Gv_megaManValues[selectedGame]["Version"] + "Buster Master: " + bossName,
            description = "Beat " + bossName + " with Mega Buster only",
            points = cheevoPoints,
            trigger =
                never(Ga_actualGame != selectedGame) && 
                never(stageID != counter) &&
                tally(1, (prev(screenID) == bossScreen - 1 && screenID == bossScreen)) &&
                repeated(0, (bossHP == bossHPDead && trigger_when(bossState == bossDefeatValue))) && 
                (   
                        never(Ga_control["Select"] > prev(Ga_control["Select"])) &&
                        never(prev(playerLife) > playerLife) &&
                        never(weaponQuantity[0] > prev(weaponQuantity[0])) &&                
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
                        never(weaponQuantity[11] < prev(weaponQuantity[11])) ||
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
                        bossName, bossHP, bossHPDead, bossState, bossDefeatValue, bossScreen
                    ){
    achievement(
        title = Gv_megaManValues[selectedGame]["Version"] + "Strategist: " + bossName,    
        description = "Beat " + bossName + " without being harmed", 
        points = cheevoPoints,
        trigger = 
            never(Ga_control["Select"] > prev(Ga_control["Select"])) &&
            never(megaManHP < prev(megaManHP)) &&
            never(Ga_actualGame != selectedGame) && 
            never(stageID != counter) &&
            tally(1, (prev(screenID) == bossScreen - 1 && screenID == bossScreen)) &&
            repeated(0, (bossHP == bossHPDead && trigger_when(bossState == bossDefeatValue)))            
    )
}

// *    Mega Buster Stage Achievement
function MegaBusterStageCheevo(
                        cheevoPoints,
                        counter,                         
                        selectedGame,                          
                        stageID, screenID, startScreenID, scrollValue, 
                        megaManHP, megaManRespawnFlag, selectedRespawnFlag,
                        bossName, screenTransition, bossScreen,
                        weaponQuantity, playerLife
                    ){
    if(counter != 0x09){                
        achievement(
            title = Gv_megaManValues[selectedGame]["Version"] + "Stage Buster Master: " + bossName,    
            description = "Reach the Boss room in " + bossName + "'s Stage with Mega Buster only", 
            points = cheevoPoints,
            trigger =            
                never(Ga_actualGame != selectedGame) &&
                never(stageID != counter) &&             
                tally(1, screenID == startScreenID  && megaManRespawnFlag == selectedRespawnFlag) &&
                repeated(0, (screenID == bossScreen - 1 && screenTransition > prev(screenTransition) && 
                    trigger_when(screenTransition == v_mm1BossValues[counter]["Scroll"]))) && (
                        never(Ga_control["Select"] > prev(Ga_control["Select"])) &&
                        never(prev(playerLife) > playerLife) &&
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
    else{
        achievement(
            title = Gv_megaManValues[selectedGame]["Version"] + "Stage Buster Master: " + bossName,    
            description = "Reach the Boss room in " + bossName + "'s Stage with Mega Buster only (except Super Arm)", 
            points = cheevoPoints,
            trigger =            
                never(Ga_actualGame != selectedGame) &&
                never(stageID != counter) &&             
                tally(1, screenID == startScreenID && megaManRespawnFlag == selectedRespawnFlag) &&
                repeated(0, (screenID == bossScreen - 1 && screenTransition > prev(screenTransition) && 
                    trigger_when(screenTransition == v_mm1BossValues[counter]["Scroll"]))) && (
                        never(Ga_control["Select"] > prev(Ga_control["Select"])) &&
                        never(prev(playerLife) > playerLife) &&
                        never(weaponQuantity[0] < prev(weaponQuantity[0])) &&                
                        never(weaponQuantity[1] < prev(weaponQuantity[1])) &&
                        never(weaponQuantity[2] < prev(weaponQuantity[2])) &&
                        never(weaponQuantity[3] < prev(weaponQuantity[3])) &&
                        never(weaponQuantity[4] < prev(weaponQuantity[4])) &&
                        never(weaponQuantity[6] < prev(weaponQuantity[6])) ||                
                        always_false()
                    )
        )    
    }
}

// *    Damageless Stage Achievement
function DamagelesssStageCheevo(
                        cheevoPoints,
                        counter,                         
                        selectedGame,                          
                        stageID, screenID, startScreenID, scrollValue, 
                        megaManHP, megaManLife, megaManRespawnFlag, selectedRespawnFlag,
                        bossName, screenTransition, bossScreen
                    ){ 
    achievement(    
        title = Gv_megaManValues[selectedGame]["Version"] + "Stage Strategist: " + bossName,    
        description = "Reach the Boss room in " + bossName + "'s Stage without being harmed", 
        points = cheevoPoints,
        trigger = 
            never(Ga_control["Select"] > prev(Ga_control["Select"])) &&
            never(megaManHP < prev(megaManHP)) &&
            never(megaManLife < prev(megaManLife)) &&
            never(Ga_actualGame != selectedGame) && 
            never(stageID != counter) &&
            tally(1, screenID == startScreenID && (megaManRespawnFlag == selectedRespawnFlag)) &&
            repeated(0, (screenID == bossScreen - 1 && screenTransition > prev(screenTransition) && trigger_when(screenTransition == scrollValue)))
    )
}



//////////////////////////////////////////////////////////////
//                                                          //
//          Mega Man I - Achievements                       //
//                                                          //
//////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
//  Extra Live Location                               //
////////////////////////////////////////////////////////
//  Boss            ScreenID    XPos        YPos      //
//                                                    //
//----------------------------------------------------//
//  Guts Man        0x0c        0x25-0x50   0x30-0x55 //
//----------------------------------------------------//
//  Wily Stage 2    0x24        0x00-0x40   0x00-0x35 //
//----------------------------------------------------//
//  Wily Stage 4    0x1c        0x55-0x80   0x75-0xa0 //
////////////////////////////////////////////////////////


////////////
// MM I - Variables
/////////////////////////////////////

v_mm1CheevoValues = {
    0x00:{"Name":"Cut Man", 
            "Clear Points":5, "MB Points":2, "DMGless Points":10, "DMGless Stage Points":0},
    0x01:{"Name":"Ice Man", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x02:{"Name":"Bomb Man", 
            "Clear Points":5, "MB Points":3, "DMGless Points":10, "DMGless Stage Points":0},
    0x03:{"Name":"Fire Man", 
            "Clear Points":5, "MB Points":3, "DMGless Points":10, "DMGless Stage Points":0},
    0x04:{"Name":"Elec Man", 
            "Clear Points":5, "MB Points":10, "DMGless Points":10, "DMGless Stage Points":0},
    0x05:{"Name":"Guts Man", 
            "Clear Points":5, "MB Points":3, "DMGless Points":10, "DMGless Stage Points":0},
    0x06:{"Name":"Yellow Devil", 
            "Clear Points":10, "MB Points":10, "DMGless Points":25, "DMGless Stage Points":0},
    0x07:{"Name":"Copy Robot", 
            "Clear Points":10, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x08:{"Name":"CWU-01P", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x09:{"Name":"Dr. Wily Machine #1", 
            "Clear Points":25, "MB Points":10, "DMGless Points":25, "DMGless Stage Points":0}
}

v_mm1BossValues = {
    //  Cut Man
    0x00:{"Defeat":0x0f, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x17},
    //  Ice Man
    0x01:{"Defeat":0x0f, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x17},
    //  Bomb Man
    0x02:{"Defeat":0x0f, "Start Screen":0x00, "Scroll":0x03, "Boss Screen":0x17},
    //  Fire Man
    0x03:{"Defeat":0x0f, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x13},
    //  Elec Man
    0x04:{"Defeat":0x0f, "Start Screen":0x00, "Scroll":0x01, "Boss Screen":0x17},
    //  Guts Man
    0x05:{"Defeat":0x0f, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x12},
    //  Yellow Devil
    0x06:{"Defeat":0x0f, "Start Screen":0x18, "Scroll":0x02, "Boss Screen":0x27},
    //  Copy Robot
    0x07:{"Defeat":0x0f, "Start Screen":0x18, "Scroll":0x03, "Boss Screen":0x29},
    //  CWU-01P
    0x08:{"Defeat":0x0f, "Start Screen":0x18, "Scroll":0x02, "Boss Screen":0x2f},
    //  Dr. Wily Machine #1
    0x09:{"Defeat":0x0d, "Start Screen":0x14, "Scroll":0x02, "Boss Screen":0x23}
}

// MM I - Constants
c_mm1BossRange = length(v_mm1BossValues) - 1
c_mm1RespawnFlag = 0xf0
c_mm1BossDeadHP = 0x00

////////////
// MM I - Addresses
/////////////////////////////////////

// *    MM I - Game Info -> Variable
a_mm1RespawnFlg = byte(0x1c11256)         // 0xf0
a_mm1StageID = byte(0x2000ac9)        
a_mm1StageScreenID = byte(0xb61fb8)
a_mm1ScreenTransition = byte(0x2000abe)   // 0x02 (Left -> Right)
a_mm1PlayerHP = byte(0x2000b02)           // 0x00 - 0x1c
a_mm1PlayerLife = byte(0x2000b3e)
a_mm1BossHP = byte(0xb62219)              // 0x00 - 0x1c
a_mm1BossState = byte(0x19a428)           // 0x0d = Wily, 0x0f = Rest

// *    MM I - Weapon Quanitity -> Variable
a_mm1Weapon = [
    byte(0x2000b03),    // Cut Man
    byte(0x2000b04),    // Ice Man
    byte(0x2000b05),    // Bomb Man
    byte(0x2000b06),    // Fire Man
    byte(0x2000b07),    // Elec Man
    byte(0x2000b08),    // Guts Man
    byte(0x2000b09),    // Magnet Beam
]


/////////////
// MM I - CALL
/////////////////////////////////////

// *    MM I - Stage Clear Achievement
//////////////////////////////////////
for counter in range(0, c_mm1BossRange){ 
    StageClearCheevo(
        v_mm1CheevoValues[counter]["Clear Points"],            
        counter, 
        Gv_megaManValues[0]["GameID"],
        a_mm1StageID, a_mm1StageScreenID, v_mm1BossValues[counter]["Start Screen"], 
        a_mm1RespawnFlg, c_mm1RespawnFlag,
        v_mm1CheevoValues[counter]["Name"], a_mm1BossHP, c_mm1BossDeadHP, a_mm1BossState, v_mm1BossValues[counter]["Defeat"], v_mm1BossValues[counter]["Boss Screen"]           
    )         
}

// *    MM I - Mega Buster Achievement
//////////////////////////////////////
for counter in range(0, c_mm1BossRange){
    MegaBusterCheevo(
        v_mm1CheevoValues[counter]["MB Points"],
        counter, 
        Gv_megaManValues[0]["GameID"],
        a_mm1StageID, a_mm1StageScreenID,
        v_mm1CheevoValues[counter]["Name"], a_mm1BossHP, c_mm1BossDeadHP, a_mm1BossState, v_mm1BossValues[counter]["Defeat"], v_mm1BossValues[counter]["Boss Screen"],
        a_mm1Weapon, a_mm1PlayerLife
    )       
} 

// *    MM I - Damageless Boss Achievement
//////////////////////////////////////
for counter in range(0, c_mm1BossRange){
    DamagelesssBossCheevo(      
        v_mm1CheevoValues[counter]["DMGless Points"],
        counter,            
        Gv_megaManValues[0]["GameID"],
        a_mm1StageID, a_mm1StageScreenID,
        a_mm1PlayerHP,
        v_mm1CheevoValues[counter]["Name"], a_mm1BossHP, c_mm1BossDeadHP, a_mm1BossState, v_mm1BossValues[counter]["Defeat"], v_mm1BossValues[counter]["Boss Screen"]
    )      
}

// *    MM I - Damageless Stage Achievement
//////////////////////////////////////
for counter in range(0, c_mm1BossRange){    
        DamagelesssStageCheevo(
            v_mm1CheevoValues[counter]["DMGless Stage Points"],
            counter,
            Gv_megaManValues[0]["GameID"],
            a_mm1StageID, a_mm1StageScreenID, v_mm1BossValues[counter]["Start Screen"], v_mm1BossValues[counter]["Scroll"],
            a_mm1PlayerHP, a_mm1PlayerLife, a_mm1RespawnFlg, c_mm1RespawnFlag,
            v_mm1CheevoValues[counter]["Name"], a_mm1ScreenTransition, v_mm1BossValues[counter]["Boss Screen"]
        )    
}  



////////////////////////////////////////////////
//                                            //
//          Mega Man II - Achievements        //
//                                            //
////////////////////////////////////////////////


////////////
// MM II - Variables
/////////////////////////////////////

v_mm2CheevoValues = {
    0x00:{"Name":"Heat Man", 
            "Clear Points":5, "MB Points":2, "DMGless Points":10, "DMGless Stage Points":0},   
    0x01:{"Name":"Air Man",     
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x02:{"Name":"Wood Man", 
            "Clear Points":5, "MB Points":3, "DMGless Points":10, "DMGless Stage Points":0},
    0x03:{"Name":"Bubble Man", 
            "Clear Points":5, "MB Points":3, "DMGless Points":10, "DMGless Stage Points":0},
    0x04:{"Name":"Quick Man", 
            "Clear Points":5, "MB Points":10, "DMGless Points":10, "DMGless Stage Points":0},
    0x05:{"Name":"Flash Man", 
            "Clear Points":5, "MB Points":3, "DMGless Points":10, "DMGless Stage Points":0},
    0x06:{"Name":"Metal Man", 
            "Clear Points":10, "MB Points":10, "DMGless Points":25, "DMGless Stage Points":0},
    0x07:{"Name":"Crash Man", 
            "Clear Points":10, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x08:{"Name":"Mecha Dragon", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x09:{"Name":"Picopico-Kun", 
            "Clear Points":25, "MB Points":10, "DMGless Points":25, "DMGless Stage Points":0},
    0x0a:{"Name":"Guts Tank", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x0b:{"Name":"Boobeam Trap", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x0c:{"Name":"Dr. Wily Machine #2", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x0d:{"Name":"Alien", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":2}
}

v_mm2BossValues = {
    //  Heat Man
    0x00:{"Defeat":0x01, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x17},
    //  Air Man
    0x01:{"Defeat":0x01, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x15},
    //  Wood Man
    0x02:{"Defeat":0x01, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x17},
    //  Bubble Man
    0x03:{"Defeat":0x01, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x15},
    //  Quick Man
    0x04:{"Defeat":0x01, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x17},
    //  Flash Man
    0x05:{"Defeat":0x01, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x13},
    //  Metal Man
    0x06:{"Defeat":0x01, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x15},
    //  Crash Man
    0x07:{"Defeat":0x01, "Start Screen":0x00, "Scroll":0x02, "Boss Screen":0x13},
    //  Mecha Dragon
    0x08:{"Defeat":0x01, "Start Screen":0x18, "Scroll":0x01, "Boss Screen":0x2a},
    //  Picopico-Kun
    0x09:{"Defeat":0x01, "Start Screen":0x18, "Scroll":0x03, "Boss Screen":0x27},
    //  Guts Tank
    0x0a:{"Defeat":0x01, "Start Screen":0x18, "Scroll":0x02, "Boss Screen":0x27},
    //  Boobeam Trap
    0x0b:{"Defeat":0x01, "Start Screen":0x16, "Scroll":0x02, "Boss Screen":0x26},
    //  Dr. Wily Machine #2
    0x0c:{"Defeat":0x01, "Start Screen":0x18, "Scroll":0x02, "Boss Screen":0x29},
    //  Alien
    0x0d:{"Defeat":0x01, "Start Screen":0x16, "Scroll":0x02, "Boss Screen":0x1f}
}

// MM II Constants
c_mm2BossRange = length(v_mm2BossValues) - 1
c_mm2RespawnFlag = 0x80
c_mm2BossDeadHP = 0x00


////////////
// MM II - Addresses
/////////////////////////////////////

// *    MM II - Game Info -> Variable
a_mm2RespawnFlg = byte(0x1b64c9f)       // 0x80
a_mm2StageID = byte(0xaed15c)        
a_mm2StageScreenID = byte(0xb61f98)
a_mm2ScreenTransition = byte(0x2000acf) // 0x02 (Left -> Right)
a_mm2PlayerHP = byte(0xb62218)          // 0x00 - 0x1c
a_mm2PlayerLife = byte(0x2000b40)
a_mm2BossHP = byte(0xb62219)            // 0x00 - 0x1c
a_mm2BossState = byte(0x2000b55)        // 0x01 = Boss beaten

// *    MM II - Weapon Quanitity -> Variable
a_mm2Weapon = [
    byte(0x2000b44),    // Special Weapon Buffer
    byte(0x2000b34),    // Heat Man
    byte(0x2000b35),    // Air Man
    byte(0x2000b36),    // Wood Man
    byte(0x2000b37),    // Bubble Man
    byte(0x2000b38),    // Quick Man
    byte(0x2000b39),    // Flash Man
    byte(0x2000b3a),    // Metal Man
    byte(0x2000b3b),    // Crash Man
    byte(0x2000b3c),    // Item-1
    byte(0x2000b3d),    // Item-2
    byte(0x2000b3e)     // Item-3    
]


/////////////
// MM II - CALL
/////////////////////////////////////

// *    MM II - Stage Clear Achievement
//////////////////////////////////////////////
for counter in range(0, c_mm2BossRange){ 
    StageClearCheevo(
        v_mm2CheevoValues[counter]["Clear Points"],            
        counter, 
        Gv_megaManValues[1]["GameID"],
        a_mm2StageID, a_mm2StageScreenID, v_mm2BossValues[counter]["Start Screen"], 
        a_mm2RespawnFlg, c_mm2RespawnFlag,
        v_mm2CheevoValues[counter]["Name"], a_mm2BossHP, c_mm2BossDeadHP, a_mm2BossState, v_mm2BossValues[counter]["Defeat"], v_mm2BossValues[counter]["Boss Screen"]           
    )         
}

// *    MM II - Mega Buster Achievement
//////////////////////////////////////////////
for counter in range(0, c_mm2BossRange){
    if(counter != c_mm2BossRange){
         MegaBusterCheevo(
            v_mm2CheevoValues[counter]["MB Points"],
            counter, 
            Gv_megaManValues[1]["GameID"],
            a_mm2StageID, a_mm2StageScreenID,
            v_mm2CheevoValues[counter]["Name"], a_mm2BossHP, c_mm2BossDeadHP, a_mm2BossState, v_mm2BossValues[counter]["Defeat"], v_mm2BossValues[counter]["Boss Screen"],
            a_mm2Weapon, a_mm2PlayerLife
        )   
    }           
} 

// *    MM II - Damageless Boss Achievement
//////////////////////////////////////////////
for counter in range(0, c_mm2BossRange){    
    DamagelesssBossCheevo(      
        v_mm2CheevoValues[counter]["DMGless Points"],
        counter,            
        Gv_megaManValues[1]["GameID"],
        a_mm2StageID, a_mm2StageScreenID,
        a_mm2PlayerHP,
        v_mm2CheevoValues[counter]["Name"], a_mm2BossHP, c_mm2BossDeadHP, a_mm2BossState, v_mm2BossValues[counter]["Defeat"], v_mm2BossValues[counter]["Boss Screen"]
    )      
}

// *    MM II - Damageless Stage Achievement
//////////////////////////////////////////////
for counter in range(0, c_mm2BossRange){
    if(counter != 0x0c && counter != 0x08){
        DamagelesssStageCheevo(        
            v_mm2CheevoValues[counter]["DMGless Stage Points"],
            counter,
            Gv_megaManValues[1]["GameID"],
            a_mm2StageID, a_mm2StageScreenID, v_mm2BossValues[counter]["Start Screen"], v_mm2BossValues[counter]["Scroll"],
            a_mm2PlayerHP, a_mm2PlayerLife, a_mm2RespawnFlg, c_mm2RespawnFlag,
            v_mm2CheevoValues[counter]["Name"], a_mm2ScreenTransition, v_mm2BossValues[counter]["Boss Screen"]
        )    
    } 
    // Mecha Dragon extra condition
    if(counter == 0x08){
        DamagelesssStageCheevo(        
            v_mm2CheevoValues[counter]["DMGless Stage Points"],
            counter,
            Gv_megaManValues[1]["GameID"],
            a_mm2StageID, a_mm2StageScreenID, v_mm2BossValues[counter]["Start Screen"], v_mm2BossValues[counter]["Scroll"],
            a_mm2PlayerHP, a_mm2PlayerLife, a_mm2RespawnFlg, c_mm2RespawnFlag,
            v_mm2CheevoValues[counter]["Name"], a_mm2ScreenTransition, v_mm2BossValues[counter]["Boss Screen"] - 4
        )    
    }
} 

//////////////////////////////////
// !!!!!!!!!!!!!!!!!!!!!!!!!!!! //
// !!!!!                  !!!!! //
// !!!!! WORK IN PROGRESS !!!!! //
// !!!!!                  !!!!! //
// !!!!!!!!!!!!!!!!!!!!!!!!!!!! //
//////////////////////////////////

////////////////////////////////////////////////
//                                            //
//          Mega Man III - Achievements       //
//                                            //
////////////////////////////////////////////////


////////////
// MM III - Variables
/////////////////////////////////////

v_mm3CheevoValues = {    
    0x00:{"Name":"Needle Man", 
            "Clear Points":5, "MB Points":2, "DMGless Points":10, "DMGless Stage Points":0},        
    0x01:{"Name":"Magnet Man", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x02:{"Name":"Gemini Man", 
            "Clear Points":5, "MB Points":3, "DMGless Points":10, "DMGless Stage Points":0},
    0x03:{"Name":"Hard Man", 
            "Clear Points":5, "MB Points":3, "DMGless Points":10, "DMGless Stage Points":0},
    0x04:{"Name":"Top Man", 
            "Clear Points":5, "MB Points":10, "DMGless Points":10, "DMGless Stage Points":0},
    0x05:{"Name":"Snake Man", 
            "Clear Points":5, "MB Points":3, "DMGless Points":10, "DMGless Stage Points":0},
    0x06:{"Name":"Spark Man", 
            "Clear Points":10, "MB Points":10, "DMGless Points":25, "DMGless Stage Points":0},
    0x07:{"Name":"Crash Man", 
            "Clear Points":10, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x08:{"Name":"", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x09:{"Name":"", 
            "Clear Points":25, "MB Points":10, "DMGless Points":25, "DMGless Stage Points":0},
    0x0a:{"Name":"", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x0b:{"Name":"", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x0c:{"Name":"", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0},
    0x0d:{"Name":"", 
            "Clear Points":5, "MB Points":5, "DMGless Points":10, "DMGless Stage Points":0}
}

v_mm3BossValues = {
    //  Needle Man
    0x00:{"Defeat":0xff, "Start Screen":0x00, "Scroll":0x01, "Boss Screen":0x12},
    //  Magnet Man
    0x01:{"Defeat":0xff, "Start Screen":0x00, "Scroll":0x01, "Boss Screen":0x14},
    //  Gemini Man
    0x02:{"Defeat":0xff, "Start Screen":0x00, "Scroll":0x01, "Boss Screen":0x1d},
    //  Hard Man
    0x03:{"Defeat":0xff, "Start Screen":0x00, "Scroll":0x01, "Boss Screen":0x17},
    //  Top Man
    0x04:{"Defeat":0xff, "Start Screen":0x00, "Scroll":0x01, "Boss Screen":0x15},
    //  Snake Man
    0x05:{"Defeat":0xff, "Start Screen":0x00, "Scroll":0x01, "Boss Screen":0x19},
    //  Spark Man
    0x06:{"Defeat":0xff, "Start Screen":0x00, "Scroll":0x01, "Boss Screen":0x17},
    //  
    0x07:{"Defeat":0xff, "Start Screen":0x00, "Scroll":0x01, "Boss Screen":0x13},
    //  
    0x08:{"Defeat":0xff, "Start Screen":0x18, "Scroll":0x01, "Boss Screen":0x2a},
    //  
    0x09:{"Defeat":0xff, "Start Screen":0x18, "Scroll":0x01, "Boss Screen":0x27},
    //  
    0x0a:{"Defeat":0xff, "Start Screen":0x18, "Scroll":0x01, "Boss Screen":0x27},
    //  
    0x0b:{"Defeat":0xff, "Start Screen":0x16, "Scroll":0x01, "Boss Screen":0x26},
    //  
    0x0c:{"Defeat":0xff, "Start Screen":0x18, "Scroll":0x01, "Boss Screen":0x29},
    //  
    0x0d:{"Defeat":0xff, "Start Screen":0x16, "Scroll":0x01, "Boss Screen":0x1f}
}

// MM III Constants
c_mm3BossRange = length(v_mm3BossValues) - 1
c_mm3RespawnFlag = 0x01
c_mm3BossDeadHP = 0xff


////////////
// MM III - Addresses
/////////////////////////////////////

// *    MM III - Game Info -> Variable
a_mm3RespawnFlg = byte(0x1af96fb)       // 0x01
a_mm3StageID = byte(0x2000aba)        
a_mm3StageScreenID = byte(0xb61ed8)
a_mm3ScreenTransition = byte(0x16e5a3) // 0x01
a_mm3PlayerHP = byte(0x2000b3a)          // 0x80 - 0x9c
a_mm3PlayerLife = byte(0x2000b46)
a_mm3BossHP = byte(0x2000b48)            // 0x00 - 0x1c
a_mm3BossState = byte(0xaeb109)        // 0xff = Boss beaten

// *    MM III - Weapon Quanitity -> Variable
a_mm3Weapon = [
    byte(0x2000b4d),    // Special Weapon Buffer
    byte(0x2000b3b),    // Gemini Man
    byte(0x2000b3c),    // Needle Man
    byte(0x2000b3d),    // Hard Man
    byte(0x2000b3e),    // Magnet Man
    byte(0x2000b3f),    // Top Man
    byte(0x2000b40),    // Snake Man
    byte(0x2000b41),    // Rush Coil
    byte(0x2000b42),    // Spark Man
    byte(0x2000b43),    // Rush Marine
    byte(0x2000b44),    // Shadow Man
    byte(0x2000b45)     // Rush Jet   
]


/////////////
// MM III - CALL
/////////////////////////////////////

// *    MM III - Stage Clear Achievement
//////////////////////////////////////////////
for counter in range(0, c_mm3BossRange){ 
    StageClearCheevo(
        v_mm3CheevoValues[counter]["Clear Points"],            
        counter, 
        Gv_megaManValues[2]["GameID"],
        a_mm3StageID, a_mm3StageScreenID, v_mm3BossValues[counter]["Start Screen"], 
        a_mm3RespawnFlg, c_mm3RespawnFlag,
        v_mm3CheevoValues[counter]["Name"], a_mm3BossHP, c_mm3BossDeadHP, a_mm3BossState, v_mm3BossValues[counter]["Defeat"], v_mm3BossValues[counter]["Boss Screen"]           
    )         
}

// *    MM III - Mega Buster Achievement
//////////////////////////////////////////////
for counter in range(0, c_mm3BossRange){
    MegaBusterCheevo(
        v_mm3CheevoValues[counter]["MB Points"],
        counter, 
        Gv_megaManValues[2]["GameID"],
        a_mm3StageID, a_mm3StageScreenID,
        v_mm3CheevoValues[counter]["Name"], a_mm3BossHP, c_mm3BossDeadHP, a_mm3BossState, v_mm3BossValues[counter]["Defeat"], v_mm3BossValues[counter]["Boss Screen"],
        a_mm3Weapon, a_mm3PlayerLife
    )       
} 

// *    MM III - Damageless Boss Achievement
//////////////////////////////////////////////
for counter in range(0, c_mm3BossRange){
    DamagelesssBossCheevo(      
        v_mm3CheevoValues[counter]["DMGless Points"],
        counter,            
        Gv_megaManValues[2]["GameID"],
        a_mm3StageID, a_mm3StageScreenID,
        a_mm3PlayerHP,
        v_mm3CheevoValues[counter]["Name"], a_mm3BossHP, c_mm3BossDeadHP, a_mm3BossState, v_mm3BossValues[counter]["Defeat"], v_mm3BossValues[counter]["Boss Screen"]
    )      
}

// *    MM III - Damageless Stage Achievement
//////////////////////////////////////////////
for counter in range(0, c_mm3BossRange){    
        DamagelesssStageCheevo(
            v_mm3CheevoValues[counter]["DMGless Stage Points"],
            counter,
            Gv_megaManValues[2]["GameID"],
            a_mm3StageID, a_mm3StageScreenID, v_mm3BossValues[counter]["Start Screen"], v_mm3BossValues[counter]["Scroll"],
            a_mm3PlayerHP, a_mm3PlayerLife, a_mm3RespawnFlg, c_mm3RespawnFlag,
            v_mm3CheevoValues[counter]["Name"], a_mm3ScreenTransition, v_mm3BossValues[counter]["Boss Screen"]
        )    
}



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
//  Boss            StageID     StageScreenID //
//                              (BossRoom)    //
//--------------------------------------------//
//  Gravity Man     0x00        0x15          //
//--------------------------------------------//
//  Stone Man       0x01        0x21          //
//--------------------------------------------//
//  Wave Man        0x02        0x43          //
//--------------------------------------------//
//  Star Man        0x03        0x16          //
//--------------------------------------------//
//  Crystal Man     0x04        0x1c          //
//--------------------------------------------//
//  Gyro Man        0x05        0x1b          //
//--------------------------------------------//
//  Charge Man      0x06        0x1c          //
//--------------------------------------------//
//  Napalm Man      0x07        0x1c          //
//--------------------------------------------//
//  Proto Man I     0x08        0x16          //
//--------------------------------------------//
//  Proto Man II    -||-        0x17          //
//--------------------------------------------//
//  Proto Man III   -||-        0x1d          //
//--------------------------------------------//
//  Proto Man IV    -||-        0x03          //
//--------------------------------------------//
//  Wily Stage I    0x09        0x1b          //
//--------------------------------------------//
//  Wily Stage II   -||-        0x18          //
//--------------------------------------------//
//  Wily Stage III  -||-        0x04          //
//--------------------------------------------//
//  Wily Stage IV   -||-        0x07          //
//--------------------------------------------//
//  Active Boss     0x0a        ----          //
//--------------------------------------------//
//  Credits         0x0c        ----          //
//--------------------------------------------//
//  Boss Select     0x0d        ----          //
//--------------------------------------------//
//  Warp Boss       0x11        ----          //
//--------------------------------------------//
//  Boss beaten     0xf0        ----          //
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


