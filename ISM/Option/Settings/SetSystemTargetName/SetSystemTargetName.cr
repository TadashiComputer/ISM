module ISM

    module Option

        class SettingsSetSystemTargetName < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SettingsSetSystemTargetName::ShortText,
                        ISM::Default::Option::SettingsSetSystemTargetName::LongText,
                        ISM::Default::Option::SettingsSetSystemTargetName::Description)
            end

            def start
                if ARGV.size == 2+Ism.debugLevel
                    showHelp
                else
                    if !Ism.ranAsSuperUser && Ism.secureModeEnabled
                        Ism.printNeedSuperUserAccessNotification
                    else
                        Ism.settings.setSystemTargetName(ARGV[2+Ism.debugLevel])
                        Ism.printProcessNotification(ISM::Default::Option::SettingsSetSystemTargetName::SetText+ARGV[2+Ism.debugLevel])
                    end
                end
            end

        end
        
    end

end
