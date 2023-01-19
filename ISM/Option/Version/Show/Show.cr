module ISM

    module Option

        class VersionShow < ISM::CommandLineOption

            def initialize
                super(  ISM::Default::Option::VersionShow::ShortText,
                        ISM::Default::Option::VersionShow::LongText,
                        ISM::Default::Option::VersionShow::Description,
                        Array(ISM::CommandLineOption).new)
            end

            def start
                #if ARGV.size == 2+Ism.debugLevel
                    #showHelp
                #else
                    puts ISM::Default::CommandLine::Title

                    processResult = IO::Memory.new

                    process = Process.run("git",args: [  "describe",
                                                            "--all"],
                                                output: processResult)
                    currentVersion = processResult.to_s.strip
                    currentVersion = currentVersion.lchop(currentVersion[0..currentVersion.rindex("/")])

                    processResult.clear

                    process = Process.run("git",args: [  "describe",
                                                            "--tags"],
                                                output: processResult)
                    currentTag = processResult.to_s.strip

                    processResult.clear

                    snapshot = (currentVersion == currentTag)

                    versionPrefix = snapshot ? "Version (snapshot): " : "Version (branch): "

                    if !snapshot
                        process = Process.run("git",args: [ "rev-parse",
                                                            "HEAD"],
                                                    output: processResult)

                        currentVersion = currentVersion+"-"+processResult.to_s.strip
                    end

                    version = versionPrefix + "#{currentVersion.colorize(:green)}"

                    puts version
                #end
            end

        end

    end

end