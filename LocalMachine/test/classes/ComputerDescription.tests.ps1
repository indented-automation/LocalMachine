$moduleBase = $psscriptroot.Substring(0, $psscriptroot.IndexOf('\test\'))
Import-Module $moduleBase -Force

InModuleScope LocalMachine {
    Describe ComputerDescription {
        BeforeAll {
            Mock Get-ComputerDescription { 'Description' }
            Mock Remove-ComputerDescription
            Mock Set-ComputerDescription
        }

        BeforeEach {
            $class = [ComputerDescription]@{
                Ensure      = 'Present'
                Description = 'Description'
            }
        }

        Context 'Get, description is set' {
            It 'Sets ensure to present and sets the value of the description property' {
                $instance = $class.Get()

                $instance.Ensure | Should -Be 'Present'
                $instance.Description | Should -Be 'Description'
            }
        }

        Context 'Get, description is not set' {
            BeforeAll {
                Mock Get-ComputerDescription
            }

            It 'Sets ensure to absent' {
                $instance = $class.Get()

                $instance.Ensure | Should -Be 'Absent'
            }
        }

        Context 'Set, description is set' {
            It 'When ensure is present, invokes Set-ComputerDescription' {
                $class.Set()

                Assert-MockCalled Set-ComputerDescription -Scope It
                Assert-MockCalled Remove-ComputerDescription -Times 0 -Scope It
            }

            It 'When ensure is absent, invokes Remove-ComputerDescription' {
                $class.Ensure = 'Absent'
                $class.Set()

                Assert-MockCalled Set-ComputerDescription -Times 0 -Scope It
                Assert-MockCalled Remove-ComputerDescription -Scope It
            }
        }

        Context 'Set, description is not set' {
            BeforeAll {
                Mock Get-ComputerDescription
            }

            It 'When ensure is present, invokes Set-ComputerDescription' {
                $class.Set()

                Assert-MockCalled Set-ComputerDescription -Scope It
                Assert-MockCalled Remove-ComputerDescription -Times 0 -Scope It
            }

            It 'When ensure is absent, invokes Remove-ComputerDescription' {
                $class.Ensure = 'Absent'
                $class.Set()

                Assert-MockCalled Set-ComputerDescription -Times 0 -Scope It
                Assert-MockCalled Remove-ComputerDescription -Scope It
            }
        }

        Context 'Test, description is set' {
            It 'When ensure is present, and the description matches, returns true' {
                $class.Test() | Should -BeTrue
            }

            It 'When ensure is present, and the description does not match, returns false' {
                $class.Description = 'New description'

                $class.Test() | Should -BeFalse
            }

            It 'When ensure is absent, returns false' {
                $class.Ensure = 'Absent'

                $class.Test() | Should -BeFalse
            }
        }

        Context 'Test, description is not set' {
            BeforeAll {
                Mock Get-ComputerDescription
            }

            It 'When ensure is present, returns false' {
                $class.Test() | Should -BeFalse
            }

            It 'When ensure is absent, returns true' {
                $class.Ensure = 'Absent'

                $class.Test() | Should -BeTrue
            }
        }
    }
}