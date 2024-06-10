module ISM

    module Option

        class SettingsSetSystemAnsiColor < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SettingsSetSystemAnsiColor::ShortText,
                        ISM::Default::Option::SettingsSetSystemAnsiColor::LongText,
                        ISM::Default::Option::SettingsSetSystemAnsiColor::Description)
            end

            def start
                if ARGV.size == 2+Ism.debugLevel
                    showHelp
                else
                    if !Ism.ranAsSuperUser && Ism.secureModeEnabled
                        Ism.printNeedSuperUserAccessNotification
                    else
                        Ism.settings.setSystemAnsiColor(ARGV[2+Ism.debugLevel])
                        Ism.printProcessNotification(ISM::Default::Option::SettingsSetSystemAnsiColor::SetText+ARGV[2+Ism.debugLevel])
                    end
                end
            end

        end
        
    end

end
