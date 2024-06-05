module ISM

    module Option

        class SoftwareInstall < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SoftwareInstall::ShortText,
                        ISM::Default::Option::SoftwareInstall::LongText,
                        ISM::Default::Option::SoftwareInstall::Description,
                        Array(ISM::CommandLineOption).new)
            end

            def start
                if ARGV.size == 2+Ism.debugLevel
                    showHelp
                else
                    if !Ism.ranAsSuperUser && Ism.secureModeEnabled
                        Ism.printNeedSuperUserAccessNotification
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

                        Ism.showCalculationTitleMessage

                        neededSoftwares = Ism.getNeededSoftwares

                        Ism.showCalculationDoneMessage
                        Ism.showSoftwares(neededSoftwares)
                        Ism.showInstallationQuestion(neededSoftwares.size)

                        userAgreement = Ism.getUserAgreement

                        if userAgreement
                            Ism.startInstallationProcess(neededSoftwares)
                        end
                    end
                end
            end

        end

    end

end
