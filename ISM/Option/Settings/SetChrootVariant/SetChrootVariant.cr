module ISM

    module Option

        class SettingsSetChrootVariant < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SettingsSetChrootVariant::ShortText,
                        ISM::Default::Option::SettingsSetChrootVariant::LongText,
                        ISM::Default::Option::SettingsSetChrootVariant::Description)
            end

            def start
                if ARGV.size == 2+Ism.debugLevel
                    showHelp
                else
                    if !Ism.ranAsSuperUser && Ism.secureModeEnabled
                        Ism.printNeedSuperUserAccessNotification
                    else
                        Ism.settings.setChrootVariant(ARGV[2+Ism.debugLevel])
                        Ism.printProcessNotification(ISM::Default::Option::SettingsSetChrootVariant::SetText+ARGV[2+Ism.debugLevel])
                    end
                end
            end

        end
        
    end

end
