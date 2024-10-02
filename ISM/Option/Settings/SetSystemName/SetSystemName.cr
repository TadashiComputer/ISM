module ISM

    module Option

        class SettingsSetSystemName < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SettingsSetSystemName::ShortText,
                        ISM::Default::Option::SettingsSetSystemName::LongText,
                        ISM::Default::Option::SettingsSetSystemName::Description)
            end

            def start
                if ARGV.size == 2
                    showHelp
                else
                    if !Ism.ranAsSuperUser && Ism.secureModeEnabled
                        Ism.printNeedSuperUserAccessNotification
                    else
                        Ism.settings.setSystemName(ARGV[2])
                        Ism.printProcessNotification(ISM::Default::Option::SettingsSetSystemName::SetText+ARGV[2])
                    end
                end
            end

        end
        
    end

end
