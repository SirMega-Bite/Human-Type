#Requires AutoHotkey v2.0-a

SlowType(str, typeSpeed) {
    tS := typeSpeed
    len := StrLen(str)
    wordStart := 1  ; Tracks the start position of each word

    Loop len {
        char := SubStr(str, A_Index, 1)

        if (char == "`r") {
            continue
        }

        SendText(char)
        rand := Random(tS * 300, tS * 550)
        Sleep(rand)

        if (char == "`n") {
            Sleep(tS * 7500)
        }

        if (char == " ") {
            Sleep(tS * 600)

            ; Occasionally delete the last word and re-type it
            if (Random(1, 10) == 1) {
                wordLength := A_Index - wordStart + 1 ; Calculate word length

                ; Backspace through the entire word
                Loop wordLength {
                    Send("{BS}")
                    Sleep(tS * 300)  ; Small delay for each backspace
                }

                ; Re-type the word
                word := SubStr(str, wordStart, wordLength)
                Loop wordLength {
                    SendText(SubStr(word, A_Index, 1))
                    Sleep(tS * 300)  ; Small delay for each character
                }

                Sleep(tS * 600)
            }

            ; Update wordStart to the next character after the space
            wordStart := A_Index + 1
        }

        if (Random(1, 15) == 1) {
            Send("{BS}")
            Sleep(ts*400)
            SendText(char) ; Re-type the last character after backspacing
            Sleep(ts*300)
        }
    }
}

^+v::SlowType(A_Clipboard, 0.4) ; (Inputs the clipboard, and a typing speed of .4)

#SuspendExempt
Esc:: {
    Suspend -1
    Pause -1
}

End::ExitApp
