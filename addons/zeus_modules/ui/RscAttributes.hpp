class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscText;
class RscListbox;
class RscCombo;
class RscEdit;
class RscXSliderH;
class RscCheckBox;
class RscActivePicture;
class RscMapControl;
class RscPicture;
class ctrlToolbox;
class RscButton;
class RscFrame;
class RscButtonMenuCancel;
class RscButtonMenuOK;

class RscDisplayAttributes {
    class Controls {
        class Background;
        class Title;
        class Content: RscControlsGroup {
            class controls;
        };
        class ButtonOK;
        class ButtonCancel;
    };
};

class GVAR(RscspawnPatient) : RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscspawnPatient))] call FUNC(ui_zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscspawnPatient))] call FUNC(ui_zeusAttributes));
	class Controls : Controls {
        class Background: Background {};
        class Title: Title {};
		class Content : Content {
			class Controls {
				class spawnPatient : RscControlsGroupNoScrollbars {
					onSetFocus = QUOTE(_this call FUNC(ui_spawnPatient));
					idc = 3813;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(4.4));
					class controls {
						class Title1 : RscText {
							idc = -1;
							text = "casualty type";
							toolTip = "";
                            x = 0;
                            y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
							colorBackground[] = {0,0,0,0.5};
						};
						class severity : RscCombo {
							idc = 3814;
                            x = QUOTE(W_PART(10.1));
                            y = 0;
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
							colorBackground[] = {0, 0, 0, 0.7};
							class Items {
								class setLight {
									text = "set light";
								};
								class setMedium {
									text = "set medium";
								};
								class setHeavy {
									text = "set heavy";
								};
								class setDead {
									text = "dead";
								};
								class randLight {
									text = "random light";
								};
								class randMedium {
									text = "random medium";
									default = 1;
								};
								class randHeavy {
									text = "random heavy";
								};

							};
						};
						class Title2 : Title1 {
							idc = -1;
							text = "casualty amount";
							toolTip = "";
							y = QUOTE(H_PART(1.1));
						};
						class amountValue : RscXSliderH {
                            idc = 3815;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(1.1));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
						};
						class Title3: Title1 {
							idc = -1;
							text = "spawning radius";
							toolTip ="";
							y = QUOTE(H_PART(2.2));
						};
						class spawnRadius : RscXSliderH {
							idc = 3816;
							x = QUOTE(W_PART(10.1));
							y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
						};
						class Title4: Title1 {
							idc = -1;
							text = "Classname list";
							toolTip = "";
							y = QUOTE(H_PART(3.3));
						};
						class fillVehicle : RscCombo  {
							idc = 3817;
							toolTip = "select which classname list should be used";
							x = QUOTE(W_PART(10.1));
							y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
							colorBackground[] = {0, 0, 0, 0.7};
							class Items {
								class array1 {
									text = "list 1";
									default = 1;
								};
								class array2 {
									text = "list 2";
								};
							};
						};
					};
				};
			};
		};
		class ButtonOk : ButtonOk {};
		class ButtonCancel : ButtonCancel {};
	};
};

class GVAR(RscaddInjury) : RscDisplayAttributes {
	onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscaddInjury))] call FUNC(ui_zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscaddInjury))] call FUNC(ui_zeusAttributes));
	class Controls : Controls {
		class Background : Background {};
		class Title : Title {};
		class Content : Content {
			class Controls {
				class addInjury : RscControlsGroupNoScrollbars {
					onSetFocus = QUOTE(_this call FUNC(ui_addInjury));
					idc = 3940;
					x = 0;
					y = 0;
					w = QUOTE(W_PART(26));
					h = QUOTE(H_PART(1.1));
					class controls {
						class Title1: RscText {
							idc = -1;
							text = "Injury type";
							toolTip = "";
							x = 0;
							y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
							colorBackground[] = {0,0,0,0.5};
						};
						class injuryType : RscCombo {
							idc = 3941;
                            x = QUOTE(W_PART(10.1));
                            y = 0;
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
							colorBackground[] = {0, 0, 0, 0.7};
							class Items {
								class randLight {
									text = "random light";
								};
								class randMedium {
									text = "random medium";
									default = 1;
								};
								class randHeavy {
									text = "random heavy";
								};
								class intoxication {
									text = "chemical intoxication";
								};

							};
						};
					};
				};
			};
		};
		class ButtonOk : ButtonOk {};
		class ButtonCancel : ButtonCancel {};
	};
};
