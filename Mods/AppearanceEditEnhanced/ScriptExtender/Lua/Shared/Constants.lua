Constants.ModUUID = "7b8366bd-abc1-4f9f-ba9d-585549b4a750"

Constants.Replications = {
    "CharacterCreationAppearance",
    "GameObjectVisual",
    "BodyType",
    "Race",
}

Constants.SaveLoadReplications = {}

Constants.PermittedCopyObjects = {
    "bg3se::Array",
    "bg3se::Object",
    "bg3se::Map",
    "table"
}

Constants.ExcludedReplications = {
    "GameObjectVisual"
}

Constants.PersistedTemplateKeys = {
    "EquipmentRace",
    "CharacterVisualResourceID",
    "VisualTemplate",
    "Icon",
    "GeneratePortrait",
    "Race",
    "Id" -- Readable
}

Constants.PersistedOriginTemplateKeys = {
    -- "AIBounds",
    "ActivationGroupId",
    "AliveInventoryType",
    "AllowReceiveDecalWhenAnimated",
    "AnimationSetResourceID",
    "AnubisConfigName",
    "AnubisNonPersistent",
    "AvoidTraps",
    "BloodSurfaceType",
    "BloodType",
    "CameraOffset",
    "CanBePickedUp",
    "CanBePickpocketed",
    "CanBeTeleported",
    "CanClimbLadders",
    "CanConsumeItems",
    "CanOpenDoors",
    "CanShootThrough",
    "CanWalkThroughDoors",
    "CastShadow",
    "CharacterVisualResourceID",
    "CollideWithCamera",
    -- "CombatComponent",
    "CoverAmount",
    "CriticalHitType",
    "DeathEffect",
    "DeathRaycastHeight",
    "DeathRaycastMaxLength",
    "DeathRaycastMinLength",
    "DeathRaycastVerticalLength",
    "DefaultDialog",
    "DefaultState",
    "DisableEquipping",
    "DisintegrateFX",
    "DisintegratedResourceID",
    -- "DisplayName",
    "Equipment",
    "EquipmentRace",
    -- "EquipmentTypes",
    -- "ExcludeInDifficulty",
    "ExplodedResourceID",
    "ExplosionFX",
    -- "FadeChildren",
    "FadeGroup",
    "Fadeable",
    "FileName",
    "FoleyLongResourceID",
    "FoleyMediumResourceID",
    "FoleyShortResourceID",
    "ForceLifetimeDeath",
    "GeneratePortrait",
    "GlobalDeletedFlag",
    "GroupID",
    "HasPlayerApprovalRating",
    "HierarchyOnlyFade",
    "Icon",
    "Id",
    "InfluenceTreasureLevel",
    "InventoryType",
    "IsDroppedOnDeath",
    "IsEquipmentLootable",
    "IsLootable",
    "IsMovementEnabled",
    "IsPlayer",
    "IsReflecting",
    "IsShadowProxy",
    "IsSimpleCharacter",
    "IsSteeringEnabled",
    "IsTradable",
    "IsWorldClimbingEnabled",
    "JumpUpLadders",
    "LadderAttachOffset",
    "LadderBlendspace_Attach_Down",
    "LadderBlendspace_Attach_Up",
    "LadderBlendspace_Detach_Down",
    "LadderBlendspace_Detach_Up",
    "LadderLoopSpeed",
    "LevelName",
    "LevelOverride",
    "LightChannel",
    "MaxDashDistance",
    "MovementAcceleration",
    "MovementSpeedDash",
    "MovementSpeedRun",
    "MovementSpeedSprint",
    "MovementSpeedStroll",
    "MovementSpeedWalk",
    "MovementStepUpHeight",
    "MovementTiltToRemap",
    "Name",
    -- "OnlyInDifficulty",
    "ParentTemplateFlags",
    "ParentTemplateId",
    "PhysicsOpenTemplate",
    "PhysicsTemplate",
    -- "PickingPhysicsTemplates",
    "ProbeLookAtOffset",
    "ProbeSpineAOffset",
    "ProbeSpineBOffset",
    "ProbeTiltToOffset",
    "Race",
    "RagdollTemplate",
    "ReceiveDecal",
    "RenderChannel",
    "SeeThrough",
    "ShootThroughType",
    "SoftBodyCollisionTemplate",
    "SoundAttenuation",
    "SoundInitEvent",
    "SoundMovementStartEvent",
    "SoundMovementStopEvent",
    "SoundObjectIndex",
    -- "SpeakerGroupList",
    "SpellSet",
    "SpotSneakers",
    "Stats",
    -- "StatusList",
    "SteeringSpeedCurveWithoutTransitions",
    "SteeringSpeedFallback",
    "SteeringSpeed_CastingCurve",
    "SteeringSpeed_MovingCurve",
    "TemplateName",
    "TemplateType",
    -- "Title",
    -- "TradeTreasures",
    -- "Transform",
    -- "Treasures",
    "TrophyID",
    "TurningNodeAngle",
    "TurningNodeOffset",
    "UseOcclusion",
    "UseSoundClustering",
    "UseStandAtDestination",
    "VFXScale",
    "VisualTemplate",
    "VocalAlertResourceID",
    "VocalAngryResourceID",
    "VocalAnticipationResourceID",
    "VocalAttackResourceID",
    "VocalAwakeResourceID",
    "VocalBoredResourceID",
    "VocalBuffResourceID",
    "VocalCinematicSuffix",
    "VocalDeathResourceID",
    "VocalDodgeResourceID",
    "VocalEffortsResourceID",
    "VocalExhaustedResourceID",
    "VocalFallResourceID",
    "VocalGaspResourceID",
    "VocalIdle1ResourceID",
    "VocalIdle2ResourceID",
    "VocalIdle3ResourceID",
    "VocalIdleCombat1ResourceID",
    "VocalIdleCombat2ResourceID",
    "VocalIdleCombat3ResourceID",
    "VocalInitiativeResourceID",
    "VocalLaughterManiacalResourceID",
    "VocalLaughterResourceID",
    "VocalNoneResourceID",
    "VocalPainResourceID",
    "VocalRebornResourceID",
    "VocalRecoverResourceID",
    "VocalRelaxedResourceID",
    "VocalShoutResourceID",
    "VocalSnoreResourceID",
    "VocalSpawnResourceID",
    "VocalVictoryResourceID",
    "VocalWeakResourceID",
    "WalkThrough",
    "WorldClimbingBlendspace_DownA",
    "WorldClimbingBlendspace_DownB",
    "WorldClimbingBlendspace_DownBHeight",
    "WorldClimbingBlendspace_UpA",
    "WorldClimbingBlendspace_UpB",
    "WorldClimbingBlendspace_UpBHeight",
    "WorldClimbingHeight",
    "WorldClimbingRadius",
    "WorldClimbingSpeed",
    -- "field_8"
}

-- In seconds
Constants.TickDelay = 2

Constants.CustomSpells = {
    ["SpellsContainer"] = "AE_Spell_Container",
    ["Resculpt"] = "Shout_Open_Creation",
    ["Mirror"] = "Shout_Open_Mirror",
    ["Respec"] = "Shout_Open_Respec",
    ["Restore"] = "Shout_Reset_Appearance"
}

Constants.DefaultUUIDs = {
    ["NullTemplate"] = "00000000-0000-0000-0000-000000000000",
    ["TempFemaleVoice"] = "be2f85e5-4bcb-4402-81ae-34a2bce3b179",
    ["TempMaleVoice"] = "f667ae40-070f-42ad-a265-b589e157015b",
    ["FullCeramorphTag"] = "FULL_CEREMORPH_3797bfc4-8004-4a19-9578-61ce0714cc0b",
    ["MagicMirrorTemplate"] = "UNI_MagicMirror_72ae7a39-d0ce-4cb6-8d74-ebdf7cdccf91",
    ["MagicMirrorDialogue"] = "GLO_MagicMirror_f9af5a3b-fb57-b69d-7526-9abdaf50db78",
    ["DarkUrgeTag"] = "fe825e69-1569-471f-9b3f-28fd3b929683",
    ["GenericTag"] = "730e82f3-c067-44a4-985b-0dfe079d4fea",
}

Constants.CharacterOrigins = {
    "S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c",
    "S_Player_Minsc_0de603c5-42e2-4811-9dad-f652de080eba",
    "S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b",
    "S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323",
    "S_Player_Jaheira_91b6b200-7d00-4d62-8dc9-99e8339dfa1a",
    "S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604",
    "S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255",
    "S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12",
    "S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d",
    "S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679"
}

Constants.CharacterOriginsUUIDs = {
    "2c76687d-93a2-477b-8b18-8a14b549304c",
    "0de603c5-42e2-4811-9dad-f652de080eba",
    "25721313-0c15-4935-8176-9f134385451b",
    "7628bc0e-52b8-42a7-856a-13a6fd413323",
    "91b6b200-7d00-4d62-8dc9-99e8339dfa1a",
    "ad9af97d-75da-406a-ae13-7071c563f604",
    "c7c13742-bacd-460a-8f65-f864fe41f255",
    "58a69333-40bf-8358-1d17-fff240d7fb12",
    "c774d764-4a17-48dc-b470-32ace9ce447d",
    "3ed74f06-3c60-42dc-83f6-f034cb47c679"
}

Constants.MaleSecretOrigins = {
    "S_Player_Minsc_0de603c5-42e2-4811-9dad-f652de080eba",
    "S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323",
}

Constants.FemaleSecretOrigins = {
    "S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b",
    "S_Player_Jaheira_91b6b200-7d00-4d62-8dc9-99e8339dfa1a",
}

Constants.GenitalTags = {
    "d27831df-2891-42e4-b615-ae555404918b",
    "a0738fdf-ca0c-446f-a11d-6211ecac3291"
}

Constants.ReallyTagsConvertion = {
    ["e8193d83-f2bc-4e21-8573-b4e158cc9363"] = "7e97c590-911f-422a-bdb6-068c137eb2c8", -- ["REALLY_AARAKOCRA"]
    ["41c6cdc9-aff5-46ae-afc4-aa0ccd9cd201"] = "2fddf7dd-f79b-4998-882c-d7257badbfe6", -- ["REALLY_AASIMAR"]
    ["c3fd1fc3-2edf-4d17-935d-44ab92406df1"] = "6591a20a-12de-46ff-bf82-b866cd97bb9a", -- ["REALLY_ASMODEUSTIEFLING"]
    ["92aae5aa-4595-4f1c-96d2-9e2499d35c6f"] = "1029b3e3-3ff0-4d73-b4ed-79b622cad4f9", -- ["REALLY_BESTIAL"]
    ["2bbc3217-3d8c-46e6-b599-a0f1c9063f9a"] = "17d29357-beba-4096-accc-c28bdea88fda", -- ["REALLY_DEEPGNOME"]
    ["ba107054-6d0a-45de-93bc-06d72d4feeb3"] = "8fac3253-331c-4b9f-95fb-e2196fd1bc8d", -- ["REALLY_DISPLACER_BEAST"]
    ["02e5e9ed-b6b2-4524-99cd-cb2bc84c754a"] = "39783f17-8484-46a6-aa3b-f3d51122e5f3", -- ["REALLY_DRAGONBORN"]
    ["a672ac1d-d088-451a-9537-3da4bf74466c"] = "676e854b-d74b-44f3-8363-3ef27164a54d", -- ["REALLY_DROWELF"]
    ["4fa13243-199d-4c9a-b455-d844276a98f5"] = "3dbe23e0-2c9f-4a81-b586-ec6e50f720e1", -- ["REALLY_DROWHALFELF"]
    ["78adf3cd-4741-47a8-94f6-f3d322432591"] = "45b007f7-f4f6-46e2-9480-395a49b87ef3", -- ["REALLY_DUERGARDWARF"]
    ["486a2562-31ae-437b-bf63-30393e18cbdd"] = "ad129444-0f41-4114-9ee5-2b9902d7ca8d", -- ["REALLY_DWARF"]
    ["351f4e42-1217-4c06-b47a-443dcf69b111"] = "772b1dc6-14be-417f-afa3-c6cf364f45b4", -- ["REALLY_ELF"]
    ["45759dc2-4d7a-4853-af73-50cfd412409b"] = "9deae354-0108-40b4-a7db-6eb23fba050f", -- ["REALLY_FIRBOLG"]
    ["09518377-4ea1-4ce2-b8e8-61477c26ebdd"] = "b0401c02-70b3-47f5-998f-8d440ad6954f", -- ["REALLY_FORESTGNOME"]
    ["48d7b679-dffd-4f68-a306-adac19de8acf"] = "aa68eccb-7875-436f-881e-c3775eee37f6", -- ["REALLY_GENASI"]
    ["677ffa76-2562-4217-873e-2253d4720ba4"] = "e49c027c-6ec6-4158-9afb-8b59236d10fd", -- ["REALLY_GITHYANKI"]
    ["1f0551f3-d769-47a9-b02b-5d3a8c51978c"] = "42483542-7915-4de5-a7d9-ac0d15fe301c", -- ["REALLY_GNOME"]
    ["34317158-8e6e-45a2-bd1e-6604d82fdda2"] = "277f9609-ad0c-4883-b56d-0850904e88df", -- ["REALLY_HALFELF"]
    ["b99b6a5d-8445-44e4-ac58-81b2ee88aab1"] = "2b40a033-7a5c-47e9-92f0-7de9b5cd3a42", -- ["REALLY_HALFLING"]
    ["3311a9a9-cdbc-4b05-9bf6-e02ba1fc72a3"] = "ab3eff19-d094-4102-88bd-d097b6b6e4f0", -- ["REALLY_HALFORC"]
    ["492c3200-1226-4114-bad1-f6b1ba737f3d"] = "78884c5f-9504-41af-912d-ce212df0ebea", -- ["REALLY_HIGHELF"]
    ["52b71dea-9d4e-402d-9700-fb9c360a44c9"] = "bb7c731c-7af7-4c2d-b3d7-b4e8bd86a244", -- ["REALLY_HIGHHALFELF"]
    ["534098fa-601d-4f6e-8c4e-b3a8d4b1f141"] = "9a92ac6d-b7cc-4ccb-8965-074c6b36a342", -- ["REALLY_HILLDWARF"]
    ["69fd1443-7686-4ca9-9516-72ec0b9d94d7"] = "8e288154-e7ca-4277-b2df-e61639b1cce8", -- ["REALLY_HUMAN"]
    ["b7215e01-b86a-4ce1-96e0-4f035afaaeae"] = "ec90a39d-ce0e-4ae1-b74d-0906dfd9a1d2", -- ["REALLY_KENKU"]
    ["57a00605-9e74-477c-bd9d-53c721e25e56"] = "da1d4f47-8583-49a1-b262-d77d361b2e09", -- ["REALLY_LIGHTFOOTHALFLING"]
    ["615d115d-6d1d-477c-8b2c-d8e91b8cfe7d"] = "ef8444e2-a240-4cc1-9f57-73db6d99bc96", -- ["REALLY_LIZARDFOLK"]
    ["ef9c5b74-56a8-48cc-b0b9-169ee16bf026"] = "c71eb8de-74e3-4d70-9826-22da7e2dc607", -- ["REALLY_LOLTHDROWELF"]
    ["ec5bea6b-26f1-4917-919c-375f67ac13d1"] = "c70e1dc2-72d4-44f9-83fd-c63d247edd9b", -- ["REALLY_MEPHISTOPHELESTIEFLING"]
    ["1dc20a7a-00e7-4126-80ad-aa1152a2136c"] = "18659b46-73ae-49d2-85a8-7e6cc43ce94f", -- ["REALLY_MOUNTAINDWARF"]
    ["bad00ba2-8a49-450c-8387-af47681717f1"] = "4cb02915-7ad7-4141-907e-93253c6a8644", -- ["REALLY_PLANAR"]
    ["d2f86ec3-c41f-47e1-8acd-984872a4d7d5"] = "987a41e3-2482-4c74-8c30-f3843cfdb7f3", -- ["REALLY_RARE"]
    ["664cc044-a0ea-43a1-b21f-d8cad7721102"] = "df697d73-5469-405a-aa95-6e1e720c5ee6", -- ["REALLY_ROCKGNOME"]
    ["6e913b6e-58b1-41bf-8751-89250dd17bff"] = "d2d60a81-688e-4d3d-ba56-3e467cae37fc", -- ["REALLY_SELDARINEDROWELF"]
    ["8d545fa1-8416-493f-8325-7d112bceced8"] = "058df86a-97b6-4dc4-a246-a1db65ff3c0f", -- ["REALLY_STOUTHALFLING"]
    ["b83aa083-9544-454e-baef-2cb28f9c151b"] = "bafc25f8-20b0-4693-a0fe-73967befcf05", -- ["REALLY_TABAXI"]
    ["aaef5d43-c6f3-434d-b11e-c763290dbe0c"] = "7bf7207f-7406-49c0-b501-eaaa2bb4efd7", -- ["REALLY_TIEFLING"]
    ["be68063a-83d0-4e3b-8d03-8127888af222"] = "7839884d-892a-4d60-95cc-b073420d8474", -- ["REALLY_TORTLE"]
    ["c622d782-f676-444a-bb31-9657b0f1415b"] = "2a7e679e-2567-47f7-9645-550471cffcf7", -- ["REALLY_TRITON"]
    ["60f6b464-752f-4970-a855-f729565b5e07"] = "2d0a73b9-f113-4d35-bdee-a31ab9163d74", -- ["REALLY_UNDERDARK"]
    ["54a4726b-9399-4e8e-825e-42c60273939e"] = "e30b5b4d-2ceb-4791-914e-b6c6c122f059", -- ["REALLY_WARFORGED"]
    ["889e0db5-d03e-4b63-86d7-13418f69729f"] = "b12e8dff-c1f0-4e9c-9ec0-1cafd22bb637", -- ["REALLY_WOODELF"]
    ["5ffb703c-3ef4-493b-966d-749bc038f6bd"] = "8ac1b27c-c5c4-4a2c-95dd-256e4349e483", -- ["REALLY_WOODHALFELF"]
    ["1ff4bf9e-a8dd-4627-8142-f60b3aa7123e"] = "3d80e0d5-0e28-4363-b153-c1a1076d36d4", -- ["REALLY_YUANTIPUREBLOOD"]
    ["ab677895-e08a-479f-a043-eac2d8447188"] = "3a5efd84-5925-4a75-83ee-4f336b56f716", -- ["REALLY_ZARIELTIEFLING"]

}

Constants.ReallyTags = {
    "7e97c590-911f-422a-bdb6-068c137eb2c8", -- ["REALLY_AARAKOCRA"]
    "2fddf7dd-f79b-4998-882c-d7257badbfe6", -- ["REALLY_AASIMAR"]
    -- "0c8221b4-43c8-4c9e-aa00-1832f4d9bcb9", -- ["REALLY_ALFIRA"]
    "6591a20a-12de-46ff-bf82-b866cd97bb9a", -- ["REALLY_ASMODEUSTIEFLING"]
    -- "ffd08582-7396-4cac-bcd4-8f9cd0fd8ef3", -- ["REALLY_ASTARION"]
    "1029b3e3-3ff0-4d73-b4ed-79b622cad4f9", -- ["REALLY_BESTIAL"]
    -- "cd611d7d-b67d-42b4-a75c-a0c6091ef8a2", -- ["REALLY_DARK_URGE"]
    "17d29357-beba-4096-accc-c28bdea88fda", -- ["REALLY_DEEPGNOME"]
    "8fac3253-331c-4b9f-95fb-e2196fd1bc8d", -- ["REALLY_DISPLACER_BEAST"]
    "39783f17-8484-46a6-aa3b-f3d51122e5f3", -- ["REALLY_DRAGONBORN"]
    "676e854b-d74b-44f3-8363-3ef27164a54d", -- ["REALLY_DROWELF"]
    "3dbe23e0-2c9f-4a81-b586-ec6e50f720e1", -- ["REALLY_DROWHALFELF"]
    "45b007f7-f4f6-46e2-9480-395a49b87ef3", -- ["REALLY_DUERGARDWARF"]
    "ad129444-0f41-4114-9ee5-2b9902d7ca8d", -- ["REALLY_DWARF"]
    "772b1dc6-14be-417f-afa3-c6cf364f45b4", -- ["REALLY_ELF"]
    "9deae354-0108-40b4-a7db-6eb23fba050f", -- ["REALLY_FIRBOLG"]
    "b0401c02-70b3-47f5-998f-8d440ad6954f", -- ["REALLY_FORESTGNOME"]
    -- "9b0354c0-56d9-4723-8034-918ac9abab19", -- ["REALLY_GALE"]
    "aa68eccb-7875-436f-881e-c3775eee37f6", -- ["REALLY_GENASI"]
    -- "264a6880-9a51-429c-a9fc-97f8952baf90", -- ["REALLY_GENERIC"]
    "e49c027c-6ec6-4158-9afb-8b59236d10fd", -- ["REALLY_GITHYANKI"]
    "42483542-7915-4de5-a7d9-ac0d15fe301c", -- ["REALLY_GNOME"]
    "277f9609-ad0c-4883-b56d-0850904e88df", -- ["REALLY_HALFELF"]
    "2b40a033-7a5c-47e9-92f0-7de9b5cd3a42", -- ["REALLY_HALFLING"]
    "ab3eff19-d094-4102-88bd-d097b6b6e4f0", -- ["REALLY_HALFORC"]
    -- "9b8709f9-8d2a-4b4e-a465-8505c561d7f5", -- ["REALLY_HALSIN"]
    "78884c5f-9504-41af-912d-ce212df0ebea", -- ["REALLY_HIGHELF"]
    "bb7c731c-7af7-4c2d-b3d7-b4e8bd86a244", -- ["REALLY_HIGHHALFELF"]
    "9a92ac6d-b7cc-4ccb-8965-074c6b36a342", -- ["REALLY_HILLDWARF"]
    "8e288154-e7ca-4277-b2df-e61639b1cce8", -- ["REALLY_HUMAN"]
    -- "8457eb5f-036c-4143-b6cf-447a9f555c7a", -- ["REALLY_JAHEIRA"]
    -- "1a2f70d6-8ead-4eb5-a824-79ee1971764a", -- ["REALLY_KARLACH"]
    "ec90a39d-ce0e-4ae1-b74d-0906dfd9a1d2", -- ["REALLY_KENKU"]
    -- "b5682d1d-c395-489c-9675-1f9b0c328ea5", -- ["REALLY_LAEZEL"]
    "da1d4f47-8583-49a1-b262-d77d361b2e09", -- ["REALLY_LIGHTFOOTHALFLING"]
    "ef8444e2-a240-4cc1-9f57-73db6d99bc96", -- ["REALLY_LIZARDFOLK"]
    "c71eb8de-74e3-4d70-9826-22da7e2dc607", -- ["REALLY_LOLTHDROWELF"]
    "c70e1dc2-72d4-44f9-83fd-c63d247edd9b", -- ["REALLY_MEPHISTOPHELESTIEFLING"]
    -- "aeb694fc-83fb-452d-819a-b97ba442dc42", -- ["REALLY_MINSC"]
    -- "3e84e1cd-2193-4f9f-80b4-c2ededefaea6", -- ["REALLY_MINTHARA"]
    "18659b46-73ae-49d2-85a8-7e6cc43ce94f", -- ["REALLY_MOUNTAINDWARF"]
    "4cb02915-7ad7-4141-907e-93253c6a8644", -- ["REALLY_PLANAR"]
    "987a41e3-2482-4c74-8c30-f3843cfdb7f3", -- ["REALLY_RARE"]
    "df697d73-5469-405a-aa95-6e1e720c5ee6", -- ["REALLY_ROCKGNOME"]
    "d2d60a81-688e-4d3d-ba56-3e467cae37fc", -- ["REALLY_SELDARINEDROWELF"]
    -- "642d2aee-e3df-47e3-9f47-bbcd441bb9e0", -- ["REALLY_SHADOWHEART"]
    "058df86a-97b6-4dc4-a246-a1db65ff3c0f", -- ["REALLY_STOUTHALFLING"]
    "bafc25f8-20b0-4693-a0fe-73967befcf05", -- ["REALLY_TABAXI"]
    "7bf7207f-7406-49c0-b501-eaaa2bb4efd7", -- ["REALLY_TIEFLING"]
    "7839884d-892a-4d60-95cc-b073420d8474", -- ["REALLY_TORTLE"]
    "2a7e679e-2567-47f7-9645-550471cffcf7", -- ["REALLY_TRITON"]
    "2d0a73b9-f113-4d35-bdee-a31ab9163d74", -- ["REALLY_UNDERDARK"]
    -- "2cff7db0-ae50-4267-82ea-84e961d3e3fa", -- ["REALLY_US"]
    "e30b5b4d-2ceb-4791-914e-b6c6c122f059", -- ["REALLY_WARFORGED"]
    "b12e8dff-c1f0-4e9c-9ec0-1cafd22bb637", -- ["REALLY_WOODELF"]
    "8ac1b27c-c5c4-4a2c-95dd-256e4349e483", -- ["REALLY_WOODHALFELF"]
    -- "5f40def5-d3ec-4698-a367-01a339888956", -- ["REALLY_WYLL"]
    "3d80e0d5-0e28-4363-b153-c1a1076d36d4", -- ["REALLY_YUANTIPUREBLOOD"]
    "3a5efd84-5925-4a75-83ee-4f336b56f716", -- ["REALLY_ZARIELTIEFLING"]
}

Constants.OriginCharacterCreationStats = {
    ["S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255"] = {
        BodyShape = 0,
        BodyType = 0,
        Race = "6c038dcb-7eb5-431d-84f8-cecfaf1c0c5a",
        SubRace = "4fda6bce-0b91-4427-901f-690c2d091c47"
    },
    ["S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12"] = {
        BodyShape = 0,
        BodyType = 1,
        Race = "bdf9b779-002c-4077-b377-8ea7c1faa795",
        SubRace = "00000000-0000-0000-0000-000000000000"
    },
    ["S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b"] = {
        BodyShape = 0,
        BodyType = 1,
        Race = "4f5d1434-5175-4fa9-b7dc-ab24fba37929",
        SubRace = "c5f8ebdd-f4a5-4d2d-9eab-4a8d1b1dd724"
    },
    ["S_Player_Jaheira_91b6b200-7d00-4d62-8dc9-99e8339dfa1a"] = {
        BodyShape = 0,
        BodyType = 1,
        Race = "45f4ac10-3c89-4fb2-b37d-f973bb9110c0",
        SubRace = "30fafb0b-7c8b-4917-bd2a-536233b35d3c"
    },
    ["S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323"] = {
        BodyShape = 1,
        BodyType = 0,
        Race = "6c038dcb-7eb5-431d-84f8-cecfaf1c0c5a",
        SubRace = "a459ba68-a9ec-4c8e-b127-602615f5b4c0"
    },
    ["S_Player_Minsc_0de603c5-42e2-4811-9dad-f652de080eba"] = {
        BodyShape = 1,
        BodyType = 0,
        Race = "0eb594cb-8820-4be6-a58d-8be7a1a98fba",
        SubRace = "00000000-0000-0000-0000-000000000000"
    },
    ["S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d"] = {
        BodyShape = 0,
        BodyType = 0,
        Race = "0eb594cb-8820-4be6-a58d-8be7a1a98fba",
        SubRace = "00000000-0000-0000-0000-000000000000"
    },
    ["S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c"] = {
        BodyShape = 1,
        BodyType = 1,
        Race = "b6dccbed-30f3-424b-a181-c4540cf38197",
        SubRace = "88d0d219-9dcb-462b-aab6-ccf31eeee2e3"
    },
    ["S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604"] = {
        BodyShape = 0,
        BodyType = 0,
        Race = "0eb594cb-8820-4be6-a58d-8be7a1a98fba",
        SubRace = "00000000-0000-0000-0000-000000000000"
    },
    ["S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679"] = {
        BodyShape = 0,
        BodyType = 1,
        Race = "45f4ac10-3c89-4fb2-b37d-f973bb9110c0",
        SubRace = "30fafb0b-7c8b-4917-bd2a-536233b35d3c"
    },
}

Constants.OriginCharacterCreationAppearances = {
    ["S_Player_Astarion_c7c13742-bacd-460a-8f65-f864fe41f255"] = {
        Elements = {
            ["1"] = {
                Color = "f265a94a-1774-48eb-90d4-201b2962e17c",
                Material = "00894ccc-31ee-4527-94d5-a408cccb3583",
                ColorIntensity = 1,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "dc318ab2-12e5-42c5-a6fb-0f9a97dd3004",
                Material = "805e1307-0eec-4cd2-a010-9477e9b802fa",
                ColorIntensity = 0.0025025177747011185,
                MetallicTint = 1033601335,
                GlossyTint = 0.36243781447410583
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] = {
                Color = "de0d5d04-a223-4024-8f2a-6ccec36af62e",
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] = {
                Color = "b3029fe3-5113-4191-b1c3-ace658bf0a5f",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 0.20,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["7"] = {
                Color = "7bb648fc-92d7-4473-860e-31c21afa280e",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "41b62f73-091c-4025-8c7b-b49d9d1f5385",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "89983ad8-9350-45a5-bbf0-0266f3f00a74",
        SkinColor = "48ede43f-7f25-4dd5-b11b-f2bb9ae74694",
        Visuals = {
            ["1"] = "00568ba9-a134-4fc9-a015-08879c400a8e",
            ["2"] = "a39569b2-8d71-4f53-8199-112f8effbf61",
            ["3"] = "6f57f3d1-b37e-44bc-b94e-ce03883e2824"
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "89983ad8-9350-45a5-bbf0-0266f3f00a74",
        HairColor = "46b0d0f2-5caa-48cd-887f-961e58b02e9d"
    },
    ["S_Player_Laezel_58a69333-40bf-8358-1d17-fff240d7fb12"] = {
        Elements = {
            ["1"] = {
                Color = "8f8019ae-4c7d-4871-8479-1219fbf6ba7e",
                Material = "3f598983-1e57-474e-b677-d51b47c90402",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "2d0b5625-5820-4e1e-a239-7c1ccfc2e1a0",
                Material = "805e1307-0eec-4cd2-a010-9477e9b802fa",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] = {
                Color = "238621c9-e7db-4634-99de-73bf3cb322fd", -- Not entirely accurate, highlights don't seem to be working
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] = {
                Color = "509e4a17-ea4c-47f2-8a3b-67f9c1a7d3f6",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["7"] = {
                Color = "7b6e7711-b951-4b3f-8cc8-f09a2107f3bc",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.10000000149011612,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "41b62f73-091c-4025-8c7b-b49d9d1f5385",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "e128e440-1b47-4ccf-b054-a04de97bf8d1",
        SkinColor = "8a99c4cd-87b4-4c2f-b74f-32e643634913",
        Visuals = {
            ["1"] = "0bb9adab-90e5-4013-ae98-96a092c389e9",
            ["2"] = "3b6f87b2-8f4e-43a1-be9c-9a65f9d82a2c"
            -- ["2"] = "864be61c-7d6e-4855-8754-d772d8c7558a",
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "e128e440-1b47-4ccf-b054-a04de97bf8d1",
        HairColor = "e81c36ee-0e29-422e-8fe9-31a0d6a1802b"
    },
    ["S_GOB_DrowCommander_25721313-0c15-4935-8176-9f134385451b"] = {
        Elements = {
            ["1"] = {
                Color = "8f8019ae-4c7d-4871-8479-1219fbf6ba7e",
                Material = "2d20d063-a9db-465a-9e8e-51979e5d842e",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "703a950a-330d-4e70-9d42-440641af7da1",
                Material = "503bb196-fee7-4e1b-8a58-c09f48bdc9d1",
                ColorIntensity = 1.0,
                MetallicTint = 1065353216,
                GlossyTint = 1.0
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] = {
                Color = "de0d5d04-a223-4024-8f2a-6ccec36af62e",
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] = {
                Color = "57104622-16a5-43fd-b7a6-8fc06aa2b976",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 0,
                MetallicTint = 0,
                GlossyTint = 0
            },
            ["7"] = {
                Color = "7bb648fc-92d7-4473-860e-31c21afa280e",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "41b62f73-091c-4025-8c7b-b49d9d1f5385",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "89983ad8-9350-45a5-bbf0-0266f3f00a74",
        SkinColor = "5b7fb798-3c6b-49e4-ad6f-5cd0d37ede59",
        Visuals = {
            ["1"] = "92a7266d-98d1-4b37-8c3e-4a5a8b5e5bb8",
            ["2"] = "a0da3200-3b71-4888-a2ae-1b1d2b45b36d"
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "89983ad8-9350-45a5-bbf0-0266f3f00a74",
        HairColor = "eed96d75-d490-415d-a5d1-8b7c5c1b2ec2"
    },
    ["S_Player_Jaheira_91b6b200-7d00-4d62-8dc9-99e8339dfa1a"] = {
        Elements = {
            ["1"] = {
                Color = "8f8019ae-4c7d-4871-8479-1219fbf6ba7e",
                Material = "00894ccc-31ee-4527-94d5-a408cccb3583",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "2d0b5625-5820-4e1e-a239-7c1ccfc2e1a0",
                Material = "805e1307-0eec-4cd2-a010-9477e9b802fa",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] = {
                Color = "55e5caa0-3ad7-4d33-b45c-625b6e7494ba",
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] = {
                Color = "696873ef-022e-4884-ac6b-38fef7de04f9",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["7"] = {
                Color = "7bb648fc-92d7-4473-860e-31c21afa280e",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "41b62f73-091c-4025-8c7b-b49d9d1f5385",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "3c669eba-b383-4079-859b-d9a5ee8cbcc6",
        SkinColor = "bffc9f01-414f-45f7-a89d-14b45c5f2155",
        Visuals = {
            ["1"] = "eb0de077-56c8-4b1a-9f30-f82d76cabe26",
            ["2"] = "703e59dd-db92-47d5-9779-96820ea18f6b",
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "3c669eba-b383-4079-859b-d9a5ee8cbcc6",
        HairColor = "444a5b3c-59c0-4abf-bc5d-06cb175c5035"
    },
    ["S_GLO_Halsin_7628bc0e-52b8-42a7-856a-13a6fd413323"] = {
        Elements = {
            ["1"] = {
                Color = "8f8019ae-4c7d-4871-8479-1219fbf6ba7e",
                Material = "00894ccc-31ee-4527-94d5-a408cccb3583",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "2d0b5625-5820-4e1e-a239-7c1ccfc2e1a0",
                Material = "805e1307-0eec-4cd2-a010-9477e9b802fa",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] = {
                Color = "de0d5d04-a223-4024-8f2a-6ccec36af62e",
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] = {
                Color = "509e4a17-ea4c-47f2-8a3b-67f9c1a7d3f6",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["7"] = {
                Color = "7bb648fc-92d7-4473-860e-31c21afa280e",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "41b62f73-091c-4025-8c7b-b49d9d1f5385",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "c3109c16-531f-463d-a6f1-6182e7965f27",
        SkinColor = "bffc9f01-414f-45f7-a89d-14b45c5f2155",
        Visuals = {
            ["1"] = "3462f953-acac-4417-9367-0966aaddcfc4",
            ["2"] = "d02a560c-dd2b-4a2f-be8d-b0b706ddcdf0",
            ["3"] = "ccfc09b8-9e49-45f9-8034-bc573875facd"
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "c3109c16-531f-463d-a6f1-6182e7965f27",
        HairColor = "6c8eb17c-d7f6-47e8-88d1-3cc16fc262bc"
    },
    ["S_Player_Minsc_0de603c5-42e2-4811-9dad-f652de080eba"] = {
        Elements = {
            ["1"] = {
                Color = "a74da1d6-422f-4c47-b883-e6b966f5d104",
                Material = "715ac24d-97cc-4409-aafe-75bc6a543ae0",
                ColorIntensity = 0.9019164443016052,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "2d0b5625-5820-4e1e-a239-7c1ccfc2e1a0",
                Material = "805e1307-0eec-4cd2-a010-9477e9b802fa",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] = {
                Color = "de0d5d04-a223-4024-8f2a-6ccec36af62e",
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] = {
                Color = "509e4a17-ea4c-47f2-8a3b-67f9c1a7d3f6",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["7"] = {
                Color = "7bb648fc-92d7-4473-860e-31c21afa280e",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "41b62f73-091c-4025-8c7b-b49d9d1f5385",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "d19b8c63-be63-4d2b-ac19-c602a2be2ab7",
        SkinColor = "dd0ecb5d-050f-4d17-9086-7fde44d03ac6",
        Visuals = {
            ["1"] = "be300236-4bc2-407c-9f84-7ca3e31f83e7",
            ["2"] = "8e460930-875f-4aac-b3f7-2506a677ff67"
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "d19b8c63-be63-4d2b-ac19-c602a2be2ab7",
        HairColor = "4c29b527-9b34-466c-9d88-33ffadebdebb"
    },
    ["S_Player_Wyll_c774d764-4a17-48dc-b470-32ace9ce447d"] = {
        Elements = {
            ["1"] = {
                Color = "8f8019ae-4c7d-4871-8479-1219fbf6ba7e",
                Material = "00894ccc-31ee-4527-94d5-a408cccb3583",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "2d0b5625-5820-4e1e-a239-7c1ccfc2e1a0",
                Material = "805e1307-0eec-4cd2-a010-9477e9b802fa",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] =
            {
                Color = "e8ca07c7-96cb-4fc6-872b-6c4fb0221c93", -- Eh, close enough
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] =
            {
                Color = "218ace6a-e833-41a5-b3b1-fed48f1cf2a2",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["7"] = {
                Color = "7bb648fc-92d7-4473-860e-31c21afa280e",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "41b62f73-091c-4025-8c7b-b49d9d1f5385",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "d19b8c63-be63-4d2b-ac19-c602a2be2ab7",
        SkinColor = "315afdac-d396-46c4-8247-b799efc5ff7a",
        Visuals = {
            ["1"] = "a35cbe20-7a31-47b7-bc1f-9b6ebfb8106a",
            ["2"] = "777562b0-a21f-46da-b487-116fd73aafc3",
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "d19b8c63-be63-4d2b-ac19-c602a2be2ab7",
        HairColor = "4c29b527-9b34-466c-9d88-33ffadebdebb"
    },
    ["S_Player_Karlach_2c76687d-93a2-477b-8b18-8a14b549304c"] = {
        Elements = {
            ["1"] = {
                Color = "8f8019ae-4c7d-4871-8479-1219fbf6ba7e",
                Material = "00894ccc-31ee-4527-94d5-a408cccb3583",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "2d0b5625-5820-4e1e-a239-7c1ccfc2e1a0",
                Material = "bd6af42b-6298-4ac7-9d55-b7f42df64c45",
                ColorIntensity = 0.7069370150566101,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] = {
                Color = "3b32ac3f-8601-4cbf-8e82-0649bfe549e9",
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] = {
                Color = "509e4a17-ea4c-47f2-8a3b-67f9c1a7d3f6",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["7"] = {
                Color = "bda61a40-1e5d-4778-bc13-2ab118d65235",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.5021149516105652,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "5b24bf00-268c-4380-9678-ff4262a1b7a7",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "421b5ee1-514b-4353-8ad8-ecd04cce718b",
        SkinColor = "42c872b2-1ef7-4e13-bdb7-83704841d520",
        Visuals = {
            ["1"] = "72b8f0a3-0db4-47c6-8336-f0e94f2b27ac",
            ["2"] = "a88ca34b-f482-4eef-903b-3a5243dbd4dc",
            ["3"] = "ae42b59a-ae23-4ed9-b020-9d791f1495ae",
            ["4"] = "479c9534-2905-4fd5-a8a9-5d8d087af777"
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "421b5ee1-514b-4353-8ad8-ecd04cce718b",
        HairColor = "4c29b527-9b34-466c-9d88-33ffadebdebb"
    },
    ["S_Player_Gale_ad9af97d-75da-406a-ae13-7071c563f604"] = {
        Elements = {
            ["1"] = {
                Color = "8f8019ae-4c7d-4871-8479-1219fbf6ba7e",
                Material = "00894ccc-31ee-4527-94d5-a408cccb3583",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "2d0b5625-5820-4e1e-a239-7c1ccfc2e1a0",
                Material = "805e1307-0eec-4cd2-a010-9477e9b802fa",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] = {
                Color = "de0d5d04-a223-4024-8f2a-6ccec36af62e",
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] = {
                Color = "a51eb7f0-6988-468e-b636-7e5d974f01da",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["7"] = {
                Color = "7bb648fc-92d7-4473-860e-31c21afa280e",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "41b62f73-091c-4025-8c7b-b49d9d1f5385",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "b86f9a40-5a9f-434b-bdc4-6145b4b64242",
        SkinColor = "3ddad742-6692-4fb8-9460-a3be64ce66e9",
        Visuals = {
            ["1"] = "f439f524-369e-495d-a2fb-3b4c06f0438c",
            ["2"] = "dfcd8866-0a7b-4040-96e9-18c14dc40f87"
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "b86f9a40-5a9f-434b-bdc4-6145b4b64242",
        HairColor = "6c8eb17c-d7f6-47e8-88d1-3cc16fc262bc"
    },
    ["S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679"] = {
        Elements = {
            ["1"] = {
                Color = "8f8019ae-4c7d-4871-8479-1219fbf6ba7e",
                Material = "00894ccc-31ee-4527-94d5-a408cccb3583",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["2"] = {
                Color = "2d0b5625-5820-4e1e-a239-7c1ccfc2e1a0",
                Material = "66470b0a-6d9a-4b21-a3d7-d8f7179eb24d",
                ColorIntensity = 0.8539987802505493,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["3"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["4"] = {
                Color = "2d0b5625-5820-4e1e-a239-7c1ccfc2e1a0",
                Material = "dbf4ab14-44c2-4ef9-b8be-35d1dfdd1c0f",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["5"] = {
                Color = "9b6db99a-29ff-42e1-aa47-252b87297be8",
                Material = "32f58f2c-525d-4b09-86ba-0c6cb0baca28",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["6"] = {
                Color = "00000000-0000-0000-0000-000000000000",
                Material = "5c6acf4c-0438-48ab-9e04-4dee7e88f8f7",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["7"] = {
                Color = "7bb648fc-92d7-4473-860e-31c21afa280e",
                Material = "3c642923-f0ec-4df2-a918-8ac63d7b8d26",
                ColorIntensity = 0.0,
                MetallicTint = 0,
                GlossyTint = 0.0
            },
            ["8"] = {
                Color = "41b62f73-091c-4025-8c7b-b49d9d1f5385",
                Material = "23d0f6e2-8491-4e3d-bfd5-73b8e671f80c",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            },
            ["9"] = {
                Color = "9926ab15-fbe8-4ec6-8a0e-18a6aa0a5a70",
                Material = "292b191c-7dc3-4bc6-8e92-5b01ff5cf6b3",
                ColorIntensity = 1.0,
                MetallicTint = 0,
                GlossyTint = 1.0
            }
        },
        EyeColor = "92a6d6bd-b7d7-4c89-ab4b-7e41b182377a",
        SkinColor = "4ffc17a5-3a58-4d38-93b6-d08455aaf602",
        Visuals = {
            ["1"] = "2536df90-05ea-492e-8fc9-33cd74a7f0cd",
            ["2"] = "06d99409-955b-474b-91ed-6fb8a69e3d3d",
            ["3"] = "0f4ba7a4-920a-4d9c-8e20-36300faa217d"
        },
        AdditionalChoices = {
            ["1"] = 0,
            ["2"] = 0,
            ["3"] = 0,
            ["4"] = 0
        },
        SecondEyeColor = "92a6d6bd-b7d7-4c89-ab4b-7e41b182377a",
        HairColor = "4c29b527-9b34-466c-9d88-33ffadebdebb"
    }
}


Constants.DefaultElements = {
    ["1"] = {
        Color = "00000000-0000-0000-0000-000000000000",
        Material = "00000000-0000-0000-0000-000000000000",
        ColorIntensity = 1.0,
        MetallicTint = 0,
        GlossyTint = 1.0
    },
    ["2"] = {
        Color = "00000000-0000-0000-0000-000000000000",
        Material = "00000000-0000-0000-0000-000000000000",
        ColorIntensity = 1.0,
        MetallicTint = 0,
        GlossyTint = 0.0
    },
    ["3"] = {
        Color = "00000000-0000-0000-0000-000000000000",
        Material = "f03b33ae-5d47-4cb5-80bc-ea06a3c55c96",
        ColorIntensity = 1.0,
        MetallicTint = 0,
        GlossyTint = 1.0
    },
    ["4"] = {
        Color = "00000000-0000-0000-0000-000000000000",
        Material = "00000000-0000-0000-0000-000000000000",
        ColorIntensity = 0.0,
        MetallicTint = 0,
        GlossyTint = 1.0
    },
    ["5"] = {
        Color = "00000000-0000-0000-0000-000000000000",
        Material = "00000000-0000-0000-0000-000000000000",
        ColorIntensity = 0.0,
        MetallicTint = 0,
        GlossyTint = 1.0
    },
    ["6"] = {
        Color = "00000000-0000-0000-0000-000000000000",
        Material = "00000000-0000-0000-0000-000000000000",
        ColorIntensity = 0.0,
        MetallicTint = 0,
        GlossyTint = 1.0
    },
    ["7"] = {
        Color = "00000000-0000-0000-0000-000000000000",
        Material = "00000000-0000-0000-0000-000000000000",
        ColorIntensity = 1.0,
        MetallicTint = 0,
        GlossyTint = 0.0
    },
    ["8"] = {
        Color = "00000000-0000-0000-0000-000000000000",
        Material = "00000000-0000-0000-0000-000000000000",
        ColorIntensity = 0.0,
        MetallicTint = 0,
        GlossyTint = 1.0
    },
    ["9"] = {
        Color = "00000000-0000-0000-0000-000000000000",
        Material = "00000000-0000-0000-0000-000000000000",
        ColorIntensity = 0.0,
        MetallicTint = 0,
        GlossyTint = 1.0
    }
}

Constants.DefaultAdditionalChoices = {
    ["1"] = 0,
    ["2"] = 0,
    ["3"] = 0,
    ["4"] = 0,
}
