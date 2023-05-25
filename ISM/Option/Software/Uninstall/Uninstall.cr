module ISM

    module Option

        class SoftwareUninstall < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SoftwareUninstall::ShortText,
                        ISM::Default::Option::SoftwareUninstall::LongText,
                        ISM::Default::Option::SoftwareUninstall::Description,
                        Array(ISM::CommandLineOption).new)
            end

            def start
                if ARGV.size == 2+Ism.debugLevel
                    showHelp
                else
                    userRequest = ARGV[2+Ism.debugLevel..-1].uniq
                    Ism.requestedSoftwares = Ism.getRequestedSoftwares(userRequest)

                    #No match found
                    if userRequest.size != Ism.requestedSoftwares.size
                        wrongArguments = Array(String).new

                        userRequest.each do |request|
                            exist = false

                            Ism.requestedSoftwares.each do |software|
                                if request == software.versionName
                                    exist = true
                                    break
                                end
                            end

                            if !exist
                                wrongArguments.push(request)
                            end
                        end

                        Ism.showNoMatchFoundMessage(wrongArguments)
                        Ism.exitProgram
                    end

                    #No available version found
                    if Ism.requestedSoftwares.any? {|software| software.version == ""}
                        wrongArguments = Array(String).new

                        Ism.requestedSoftwares.each do |software|
                            if software.version == ""
                                wrongArguments.push(software.versionName)
                            end
                        end

                        Ism.showNoVersionAvailableMessage(wrongArguments)
                        Ism.exitProgram
                    end

                    #Software not installed
                    Ism.requestedSoftwares.each do |software|
                        wrongArguments = Array(String).new

                        if !Ism.softwareIsInstalled(software)
                            wrongArguments.push(software.name)
                        end

                        Ism.showSoftwareNotInstalledMessage(wrongArguments)
                        Ism.exitProgram
                    end

                    Ism.showCalculationTitleMessage

                    unneededSoftwares = Ism.getUnneededSoftwares

                    Ism.showCalculationDoneMessage
                    Ism.showSoftwares(unneededSoftwares)
                    Ism.showUninstallationQuestion(unneededSoftwares.size)

                    userAgreement = Ism.getUserAgreement

                    if userAgreement
                        Ism.startUninstallationProcess(unneededSoftwares)
                    end
                end
            end

        end

    end

end