$moduleBase = $psscriptroot.Substring(0, $psscriptroot.IndexOf('\test\'))
Import-Module $moduleBase -Force

InModuleScope LocalMachine {
    Describe TestComputerDescriptionValue {
    }
}