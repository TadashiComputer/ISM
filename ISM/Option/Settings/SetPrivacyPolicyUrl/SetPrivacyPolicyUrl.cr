module ISM

    module Option

        class SettingsSetPrivacyPolicyUrl < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SettingsSetPrivacyPolicyUrl::ShortText,
                        ISM::Default::Option::SettingsSetPrivacyPolicyUrl::LongText,
                        ISM::Default::Option::SettingsSetPrivacyPolicyUrl::Description)
            end

            def start
                if ARGV.size == 2+Ism.debugLevel
                    showHelp
                else
                    if !Ism.ranAsSuperUser && Ism.secureModeEnabled
                        Ism.printNeedSuperUserAccessNotification
                    else
                        Ism.settings.setPrivacyPolicyUrl(ARGV[2+Ism.debugLevel])
                        Ism.printProcessNotification(ISM::Default::Option::SettingsSetPrivacyPolicyUrl::SetText+ARGV[2+Ism.debugLevel])
                    end
                end
            end

        end
        
    end

end
