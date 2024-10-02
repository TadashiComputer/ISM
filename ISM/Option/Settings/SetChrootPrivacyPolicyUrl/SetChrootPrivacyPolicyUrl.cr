module ISM

    module Option

        class SettingsSetChrootPrivacyPolicyUrl < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::SettingsSetChrootPrivacyPolicyUrl::ShortText,
                        ISM::Default::Option::SettingsSetChrootPrivacyPolicyUrl::LongText,
                        ISM::Default::Option::SettingsSetChrootPrivacyPolicyUrl::Description)
            end

            def start
                if ARGV.size == 2
                    showHelp
                else
                    if !Ism.ranAsSuperUser && Ism.secureModeEnabled
                        Ism.printNeedSuperUserAccessNotification
                    else
                        Ism.settings.setChrootPrivacyPolicyUrl(ARGV[2])
                        Ism.printProcessNotification(ISM::Default::Option::SettingsSetChrootPrivacyPolicyUrl::SetText+ARGV[2])
                    end
                end
            end

        end
        
    end

end
