module ISM

    module Option

        class SettingsSetChrootRelease < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SettingsSetChrootRelease::ShortText,
                        ISM::Default::Option::SettingsSetChrootRelease::LongText,
                        ISM::Default::Option::SettingsSetChrootRelease::Description)
            end

            def start
                if ARGV.size == 2+Ism.debugLevel
                    showHelp
                else
                    if !Ism.ranAsSuperUser && Ism.secureModeEnabled
                        Ism.printNeedSuperUserAccessNotification
                    else
                        Ism.settings.setChrootRelease(ARGV[2+Ism.debugLevel])
                        Ism.printProcessNotification(ISM::Default::Option::SettingsSetChrootRelease::SetText+ARGV[2+Ism.debugLevel])
                    end
                end
            end

        end
        
    end

end
