module ISM

    module Option

        class SettingsSetChrootSystemName < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SettingsSetChrootSystemName::ShortText,
                        ISM::Default::Option::SettingsSetChrootSystemName::LongText,
                        ISM::Default::Option::SettingsSetChrootSystemName::Description,
                        Array(ISM::CommandLineOption).new)
            end

            def start
                if ARGV.size == 2+Ism.debugLevel
                    showHelp
                else
                    Ism.settings.setChrootSystemName(ARGV[2+Ism.debugLevel])
                    puts    "#{"* ".colorize(:green)}" +
                            ISM::Default::Option::SettingsSetChrootSystemName::SetText +
                            ARGV[2+Ism.debugLevel]
                end
            end

        end
        
    end

end