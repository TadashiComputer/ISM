module ISM

    module Option

        class SettingsSetSystemBuildOptions < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SettingsSetSystemBuildOptions::ShortText,
                        ISM::Default::Option::SettingsSetSystemBuildOptions::LongText,
                        ISM::Default::Option::SettingsSetSystemBuildOptions::Description)
            end

            def start
                if ARGV.size == 2+Ism.debugLevel
                    showHelp
                else
                    if !Ism.ranAsSuperUser && Ism.secureModeEnabled
                        Ism.printNeedSuperUserAccessNotification
                    else
                        Ism.settings.setSystemBuildOptions(ARGV[2+Ism.debugLevel])
                        Ism.printProcessNotification(ISM::Default::Option::SettingsSetSystemBuildOptions::SetText+ARGV[2+Ism.debugLevel])
                    end
                end
            end

        end
        
    end

end
