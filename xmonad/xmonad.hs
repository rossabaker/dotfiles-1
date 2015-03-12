import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Actions.WindowGo
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Prompt 
import XMonad.Prompt (defaultXPConfig, autoComplete)
import XMonad.Prompt.Window (windowPromptGoto, windowPromptBring)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig
import System.IO

myMask :: KeyMask
myMask = mod4Mask

main = do
  xmproc <- spawnPipe "pkill xmobar; /usr/bin/xmobar /home/ross/.xmobarrc"
  xmonad $ 
     defaultConfig
     { borderWidth = 3
     , focusedBorderColor = "gray80"
     , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
     , manageHook = manageHook defaultConfig <+> manageDocks
     , modMask = myMask
     , normalBorderColor = "gray20"
     , startupHook = setWMName "LG3D"
     , terminal = "gnome-terminal"
     } `additionalKeys` myKeys

myXPConfig :: XPConfig
myXPConfig = defaultXPConfig 
           { bgColor = "#333333"
           , fgColor = "#f8f8f8"
           , fgHLight = "#ffffff"
           , bgHLight = "#999999"
           , borderColor = "#666666"
           , font = "xft:DejaVu Sans Mono:pixelsize=20"
           , height = 30 
           }

myKeys = 
  [ ((0, xF86XK_AudioMute), spawn "amixer -D pulse set Master toggle")
  , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 1-")
  , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 1+")
  , ((myMask, xK_b), windowPromptBring myXPConfig)
  , ((myMask, xK_g), windowPromptGoto myXPConfig { autoComplete = Just 500000 })
  , ((myMask, xK_w), runOrRaiseNext "google-chrome" (className =? "Google-chrome"))
  , ((myMask, xK_i), runOrRaiseNext "xchat" (className =? "Xchat"))
  ]
