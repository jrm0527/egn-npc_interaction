# egn-npc_interaction
NPC Interaction is similar to FivePD but designed to work with QB-Core. It requires the following changes to qb-radialmenu/config.lua

Replace the section labelled "police" with the following.

    ["police"] = {
        {
            id = 'emergencybutton',
            title = 'Emergency button',
            icon = 'bell',
            type = 'client',
            event = 'police:client:SendPoliceEmergencyAlert',
            shouldClose = true
        }, {
            id = 'checkvehstatus',
            title = 'Check Tune Status',
            icon = 'circle-info',
            type = 'client',
            event = 'qb-tunerchip:client:TuneStatus',
            shouldClose = true
        }, {
            id = 'resethouse',
            title = 'Reset house lock',
            icon = 'key',
            type = 'client',
            event = 'qb-houses:client:ResetHouse',
            shouldClose = true
        }, {
            id = 'takedriverlicense',
            title = 'Revoke Drivers License',
            icon = 'id-card',
            type = 'client',
            event = 'police:client:SeizeDriverLicense',
            shouldClose = true
        }, {
            id = 'policeinteraction',
            title = 'Police Actions',
            icon = 'list-check',
            items = {
                {
                    id = 'statuscheck',
                    title = 'Check Health Status',
                    icon = 'heart-pulse',
                    type = 'client',
                    event = 'hospital:client:CheckStatus',
                    shouldClose = true
                }, {
                    id = 'checkstatus',
                    title = 'Check status',
                    icon = 'question',
                    type = 'client',
                    event = 'police:client:CheckStatus',
                    shouldClose = true
                }, {
                    id = 'escort',
                    title = 'Escort',
                    icon = 'user-group',
                    type = 'client',
                    event = 'police:client:EscortPlayer',
                    shouldClose = true
                }, {
                    id = 'searchplayer',
                    title = 'Search',
                    icon = 'magnifying-glass',
                    type = 'client',
                    event = 'police:client:SearchPlayer',
                    shouldClose = true
                }, {
                    id = 'jailplayer',
                    title = 'Jail',
                    icon = 'user-lock',
                    type = 'client',
                    event = 'police:client:JailPlayer',
                    shouldClose = true
                }
            }
        }, {
            id = 'npcinteraction',
            title = 'NPC Actions',
            icon = 'list-check',
            items = {
                {
                    id = 'mimic',
                    title = 'Mimic player vehicle',
                    icon = 'user-group',
                    type = 'client',
                    event = 'egn-npc:mimic',
                    shouldClose = true
                }, {
                    id = 'runplate',
                    title = 'Run Vehicle Plate',
                    icon = 'car',
                    type = 'client',
                    event = 'egn-npc:client:getplate',
                    shouldClose = true
                }, {
                    id = 'runid',
                    title = 'Run Driver ID',
                    icon = 'id-card',
                    type = 'client',
                    event = 'egn-npc:client:getid',
                    shouldClose = true
                }, 	{
                    id = 'setspeech',
                    title = 'Set Speech Type',
                    icon = 'comments',
                    items = {
						{
							id = 'setnormal',
							title = 'Normal Speech',
							icon = 'comments',
							type = 'client',
							event = 'egn-npc:client:setSpeechNormal',
							shouldClose = false
						}, {
							id = 'setaggressive',
							title = 'Aggressive Speech',
							icon = 'person-harassing',
							type = 'client',
							event = 'egn-npc:client:setSpeechAggressive',
							shouldClose = false
						}
					}
                }, {
                    id = 'dialogue',
                    title = 'Dialogue',
                    icon = 'question',
                    items = {
						{
							id = 'hello',
							title = 'Hello',
							icon = 'comments',
							type = 'client',
							event = 'egn-npc:client:hello',
							shouldClose = false
						}, {
							id = 'askid',
							title = 'Ask For ID',
							icon = 'id-card',
							type = 'client',
							event = 'egn-npc:client:askid',
							shouldClose = true
						}, {
							id = 'asksearch',
							title = 'Ask Search Vehicle',
							icon = 'magnifying-glass',
							type = 'client',
							event = 'egn-npc:client:asksearch',
							shouldClose = false
						}, {
							id = 'illegal',
							title = 'Anything illegal?',
							icon = 'cannabis',
							type = 'client',
							event = 'egn-npc:client:illegal',
							shouldClose = false
						}, {
							id = 'drugs',
							title = 'Taken any drugs?',
							icon = 'cannabis',
							type = 'client',
							event = 'egn-npc:client:drug',
							shouldClose = false
						}, {
							id = 'drunk',
							title = 'Anything to drink?',
							icon = 'wine-bottle',
							type = 'client',
							event = 'egn-npc:client:drunk',
							shouldClose = false
						}, {
							id = 'release',
							title = 'Free to go',
							icon = 'angles-right',
							type = 'client',
							event = 'egn-npc:client:release',
							shouldClose = true
						}
					}
				}, {
                    id = 'interactions',
                    title = 'Interactions',
                    icon = 'question',
                    items = {
						{
							id = 'citations',
							title = 'Citations',
							icon = 'comments',
							items = {
								{
									id = 'ticket',
									title = 'Issue Ticket',
									icon = 'comments',
									type = 'client',
									event = 'egn-npc:client:ticket',
									shouldClose = true
								}, {
									id = 'warning',
									title = 'Issue Warning',
									icon = 'comments',
									type = 'client',
									event = 'egn-npc:client:warn',
									shouldClose = true
								}
							}
						}, {
							id = 'orderout',
							title = 'Out of Vehicle',
							icon = 'id-card',
							type = 'client',
							event = 'egn-npc:client:exit',
							shouldClose = true
						}, {
							id = 'orderin',
							title = 'Return to Vehicle',
							icon = 'magnifying-glass',
							type = 'client',
							event = 'egn-npc:client:mount',
							shouldClose = true
						}, {
							id = 'breathalyzer',
							title = 'Use Breathalyzer',
							icon = 'magnifying-glass',
							type = 'client',
							event = 'egn-npc:client:breathtest',
							shouldClose = true
						}, {
							id = 'drugalyzer',
							title = 'Test for Drugs',
							icon = 'magnifying-glass',
							type = 'client',
							event = 'egn-npc:client:drugtest',
							shouldClose = true
						}, {
							id = 'searchveh',
							title = 'Search Vehicle',
							icon = 'magnifying-glass',
							type = 'client',
							event = 'egn-npc:client:searchveh',
							shouldClose = true
						}
					}
				}
			}
        },	{
            id = 'policeobjects',
            title = 'Objects',
            icon = 'road',
            items = {
                {
                    id = 'spawnpion',
                    title = 'Cone',
                    icon = 'triangle-exclamation',
                    type = 'client',
                    event = 'police:client:spawnCone',
                    shouldClose = false
                }, {
                    id = 'spawnhek',
                    title = 'Gate',
                    icon = 'torii-gate',
                    type = 'client',
                    event = 'police:client:spawnBarrier',
                    shouldClose = false
                }, {
                    id = 'spawnschotten',
                    title = 'Speed Limit Sign',
                    icon = 'sign-hanging',
                    type = 'client',
                    event = 'police:client:spawnRoadSign',
                    shouldClose = false
                }, {
                    id = 'spawntent',
                    title = 'Tent',
                    icon = 'campground',
                    type = 'client',
                    event = 'police:client:spawnTent',
                    shouldClose = false
                }, {
                    id = 'spawnverlichting',
                    title = 'Lighting',
                    icon = 'lightbulb',
                    type = 'client',
                    event = 'police:client:spawnLight',
                    shouldClose = false
                }, {
                    id = 'spikestrip',
                    title = 'Spike Strips',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'police:client:SpawnSpikeStrip',
                    shouldClose = false
                }, {
                    id = 'deleteobject',
                    title = 'Remove object',
                    icon = 'trash',
                    type = 'client',
                    event = 'police:client:deleteObject',
                    shouldClose = false
                }
            }
        }
    },
