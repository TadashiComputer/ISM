module ISM

    module Option

        class Settings < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::Settings::ShortText,
                        ISM::Default::Option::Settings::LongText,
                        ISM::Default::Option::Settings::Description,
                        ISM::Default::Option::Settings::Options)
            end

            def start
                if ARGV.size == 1
                    showHelp
                else
                    matchingOption = false
    
                    @options.each_with_index do |argument, index|
                        if ARGV[1] == argument.shortText || ARGV[1] == argument.longText
                            matchingOption = true
                            @options[index].start
                            break
                        end
                    end
    
                    if !matchingOption
                        puts "#{ISM::Default::CommandLine::ErrorUnknowArgument.colorize(:yellow)}" + "#{ARGV[0].colorize(:white)}"
                        puts    "#{ISM::Default::CommandLine::ErrorUnknowArgumentHelp1.colorize(:white)}" +
                                "#{ISM::Default::CommandLine::ErrorUnknowArgumentHelp2.colorize(:green)}" +
                                "#{ISM::Default::CommandLine::ErrorUnknowArgumentHelp3.colorize(:white)}"
                    end
                end
            end

        end
        
    end

end
