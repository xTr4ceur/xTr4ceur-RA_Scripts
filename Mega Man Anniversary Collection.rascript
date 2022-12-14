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
    0x00:{"Version":"[MM I] ", "GameID":0x00},
    0x01:{"Version":"[MM II] ", "GameID":0x01},
    0x02:{"Version":"[MM III] ", "GameID":0x02},
    0x03:{"Version":"[MM IV] ", "GameID":0x03},
    0x04:{"Version":"[MM V] ", "GameID":0x04},
    0x05:{"Version":"[MM VI] ", "GameID":0x05},
    0x06:{"Version":"[MM VII] ", "GameID":0x06},
    0x07:{"Version":"[MM 8] ", "GameID":0x07},
    0x08:{"Version":"[MM TPB] ", "GameID":0x08},
    0x09:{"Version":"[MM 2 TPF] ", "GameID":0x09} 
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
            title = Ga_megaManValues[selectedGame]["Version"] + "Buster Master: " + bossName,
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
            repeated(0, (screenID == bossScreen - 1 && screenTransition > prev(screenTransition) && trigger_when(screenTransition == v_mm1BossValues[counter]["Scroll"])))
    )
}



//////////////////////////////////////////////////////////////
//                                                          //
//          Mega Man I - Achievements                       //
//                                                          //
//////////////////////////////////////////////////////////////
//  Boss            StageID     StageScreenID   ScrollValue //
//                              (BossRoom)                  //
//----------------------------------------------------------//
//  Cut Man         0x00        0x17            0x02        //
//----------------------------------------------------------//
//  Ice Man         0x01        0x17            0x02        //
//----------------------------------------------------------//
//  Bomb Man        0x02        0x17            0x03        //
//----------------------------------------------------------//
//  Fire Man        0x03        0x13            0x02        //
//----------------------------------------------------------//
//  Elec Man        0x04        0x17            0x01        //
//----------------------------------------------------------//
//  Guts Man        0x05        0x12            0x02        //
//----------------------------------------------------------//
//  Yellow Devil    0x06        0x27            0x02        //
//----------------------------------------------------------//
//  Copy Robot      0x07        0x29            0x03        //
//----------------------------------------------------------//
//  CWU-01P         0x08        0x2f            0x02        //
//----------------------------------------------------------//
//  Wily Machine #1 0x09        0x23            0x02        //
//////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
//  Extra Live Location                               //
////////////////////////////////////////////////////////
//  Boss            ScreenID    XPos        YPos      //
//                                                    //
//----------------------------------------------------//
//  Guts Man        0x0c        0x25-0x50   0x30-0x55 //
////////////////////////////////////////////////////////


////////////
// MM1 - Variables
/////////////////////////////////////

v_mm1CheevoValues = {
    //  Cut Man
    0x00:{"Name":"Cut Man", "Clear Points":5, "MB Points":2, "DMGless Points":10, "MB Stage Points":5, "DMGless Stage Points":0},
    //  Ice Man    
    0x01:{"Name":"Ice Man", "Clear Points":5, "MB Points":5, "DMGless Points":10, "MB Stage Points":10, "DMGless Stage Points":0},
    //  Bomb Man
    0x02:{"Name":"Bomb Man", "Clear Points":5, "MB Points":3, "DMGless Points":10, "MB Stage Points":0, "DMGless Stage Points":0},
    //  Fire Man
    0x03:{"Name":"Fire Man", "Clear Points":5, "MB Points":3, "DMGless Points":10, "MB Stage Points":0, "DMGless Stage Points":0},
    //  Elec Man
    0x04:{"Name":"Elec Man", "Clear Points":5, "MB Points":10, "DMGless Points":10, "MB Stage Points":0, "DMGless Stage Points":0},
    //  Guts Man
    0x05:{"Name":"Guts Man", "Clear Points":5, "MB Points":3, "DMGless Points":10, "MB Stage Points":0, "DMGless Stage Points":0},
    //  Yellow Devil
    0x06:{"Name":"Yellow Devil", "Clear Points":10, "MB Points":10, "DMGless Points":25, "MB Stage Points":0, "DMGless Stage Points":0},
    // Copy Robot
    0x07:{"Name":"Copy Robot", "Clear Points":10, "MB Points":5, "DMGless Points":10, "MB Stage Points":0, "DMGless Stage Points":0},
    //  CWU-01P
    0x08:{"Name":"CWU-01P", "Clear Points":5, "MB Points":5, "DMGless Points":10, "MB Stage Points":0, "DMGless Stage Points":0},
    //  Dr. Wily Machine #1
    0x09:{"Name":"Dr. Wily Machine #1", "Clear Points":25, "MB Points":10, "DMGless Points":25, "MB Stage Points":0, "DMGless Stage Points":0}
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
    // Copy Robot
    0x07:{"Defeat":0x0f, "Start Screen":0x18, "Scroll":0x03, "Boss Screen":0x29},
    //  CWU-01P
    0x08:{"Defeat":0x0f, "Start Screen":0x18, "Scroll":0x02, "Boss Screen":0x2f},
    //  Dr. Wily Machine #1
    0x09:{"Defeat":0x0d, "Start Screen":0x14, "Scroll":0x02, "Boss Screen":0x23}
}

// Mega Man 1 Constants
v_mm1YellowDevilStageID = 0x06
v_mm1BossRange = 0x09
v_mm1RespawnFlag = 0xf0

////////////
// MM1 - Addresses
/////////////////////////////////////

// *    Game Info -> Variable
a_mm1RespawnFlg = byte(0x1c11256)         // 0xf0
a_mm1StageID = byte(0x2000ac9)        
a_mm1StageScreenID = byte(0xb61fb8)
a_mm1ScreenTransition = byte(0x2000abe)   // 0x02 (Left -> Right)
a_mm1PlayerHP = byte(0x2000b02)           // 0x00 - 0x1c
a_mm1PlayerLife = byte(0x2000b3e)
a_mm1BossHP = byte(0xb62219)              // 0x00 - 0x1c
a_mm1BossState = byte(0x19a428)           // 0x0d = Wily, 0x0f = Rest

// *    Weapon Quanitity -> Variable
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
// MM1 - CALL
/////////////////////////////////////

// *    Stage Clear Achievement
//////////////////////////////////////
for counter in range(0, v_mm1BossRange){ 
    StageClearCheevo(
        v_mm1CheevoValues[counter]["Clear Points"],            
        counter, 
        Gv_megaManValues[0]["GameID"],
        a_mm1StageID, a_mm1StageScreenID, v_mm1BossValues[counter]["Start Screen"], 
        a_mm1RespawnFlg, v_mm1RespawnFlag,
        v_mm1CheevoValues[counter]["Name"], a_mm1BossHP, 0x00, a_mm1BossState, v_mm1BossValues[counter]["Defeat"], v_mm1BossValues[counter]["Boss Screen"]           
    )         
}

// *    Mega Buster Achievement
//////////////////////////////////////
for counter in range(0, v_mm1BossRange){
    MegaBusterCheevo(
        v_mm1CheevoValues[counter]["MB Points"],
        counter, 
        Gv_megaManValues[0]["GameID"],
        a_mm1StageID, a_mm1StageScreenID,
        v_mm1CheevoValues[counter]["Name"], a_mm1BossHP, 0x00, a_mm1BossState, v_mm1BossValues[counter]["Defeat"], v_mm1BossValues[counter]["Boss Screen"],
        a_mm1Weapon, a_mm1PlayerLife
    )       
} 

// *    Damageless Boss Achievement
//////////////////////////////////////
for counter in range(0, v_mm1BossRange){
    DamagelesssBossCheevo(      
        v_mm1CheevoValues[counter]["DMGless Points"],
        counter,            
        Gv_megaManValues[0]["GameID"],
        a_mm1StageID, a_mm1StageScreenID,
        a_mm1PlayerHP,
        v_mm1CheevoValues[counter]["Name"], a_mm1BossHP, 0x00, a_mm1BossState, v_mm1BossValues[counter]["Defeat"], v_mm1BossValues[counter]["Boss Screen"]
    )      
} 

// *    Mega Buster Stage Achievement
//////////////////////////////////////
for counter in range(0, v_mm1BossRange){
    if(counter != v_mm1YellowDevilStageID){
        MegaBusterStageCheevo(          
            v_mm1CheevoValues[counter]["MB Stage Points"],
            counter,                         
            Gv_megaManValues[0]["GameID"],                          
            a_mm1StageID, a_mm1StageScreenID, v_mm1BossValues[counter]["Start Screen"], v_mm1BossValues[counter]["Scroll"], 
            a_mm1PlayerHP, a_mm1RespawnFlg, v_mm1RespawnFlag,
            v_mm1CheevoValues[counter]["Name"], a_mm1ScreenTransition, v_mm1BossValues[counter]["Boss Screen"],
            a_mm1Weapon, a_mm1PlayerLife
        )
    }
}



// *    Damageless Stage Achievement
//////////////////////////////////////
for counter in range(0, v_mm1BossRange){    
        DamagelesssStageCheevo(
            v_mm1CheevoValues[counter]["DMGless Stage Points"],
            counter,
            Gv_megaManValues[0]["GameID"],
            a_mm1StageID, a_mm1StageScreenID, v_mm1BossValues[counter]["Start Screen"], v_mm1BossValues[counter]["Scroll"],
            a_mm1PlayerHP, a_mm1PlayerLife, a_mm1RespawnFlg, v_mm1RespawnFlag,
            v_mm1CheevoValues[counter]["Name"], a_mm1ScreenTransition, v_mm1BossValues[counter]["Boss Screen"]
        )    
}  



////////////////////////////////////////////////
//                                            //
//          Mega Man II - Achievements        //
//                                            //
////////////////////////////////////////////////
//  Boss            StageID     StageScreenID //
//                              (BossRoom)    //
//--------------------------------------------//
//  Heat Man        0x00        0x17          //
//--------------------------------------------//
//  Air Man         0x01        0x15          //
//--------------------------------------------//
//  Wood Man        0x02        0x17          //
//--------------------------------------------//  
//  Bubble Man      0x03        0x15          //
//--------------------------------------------//
//  Quick Man       0x04        0x17          //
//--------------------------------------------//
//  Flash Man       0x05        0x13          //
//--------------------------------------------//
//  Metal Man       0x06        0x15          //
//--------------------------------------------//      
//  Crash Man       0x07        0x13          //
//--------------------------------------------//
//  Mecha Dragon    0x08        0x2a          //
//--------------------------------------------//
//  Picopico-Kun    0x09        0x27          //
//--------------------------------------------//
//  Guts Tank       0x0a        0x27          //
//--------------------------------------------//
//  Boobeam Trap    0x0b        0x26          //
//--------------------------------------------//
//  Wily Machine #2 0x0c        0x29          //
//--------------------------------------------//
//  Alien           0x0d        0x1f          //
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
    "Dr. Wily Machine #2",
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

// *    Stage Clear Achievement
//////////////////////////////////////


// *    Mega Buster Achievement
//////////////////////////////////////


// *    Damageless Boss Achievement
//////////////////////////////////////



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


