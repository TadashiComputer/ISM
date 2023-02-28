module ISM

    class SoftwareDependency

        property name : String
        property options : Array(String)

        def initialize
            @name = String.new
            @version = String.new
            @options = Array(String).new
        end

        def getEnabledPass : String
            @options.each do |option|
                if option.starts_with?(/Pass[0-9]/)
                    return option
                end
            end

            return String.new
        end

        def hiddenName : String
            passName = getEnabledPass
            return (passName == "" ? @name : @name+"-"+passName)
        end

        def version=(@version)
        end

        def includeComparators : Bool
            return @version.includes?("<") || @version.includes?(">")
        end

        def greaterComparator : Bool
            return @version[0] == ">" && @version[1] != "="
        end

        def lessComparator : Bool
            return @version[0] == "<" && @version[1] != "="
        end

        def greaterOrEqualComparator : Bool
            return @version[0..1] == ">="
        end

        def lessOrEqualComparator : Bool
            return @version[0..1] == "<="
        end

        def version
            availableVersion = @version

            if includeComparators
                if greaterComparator
                    temporaryAvailableVersion = SemanticVersion.parse(@version.tr("><=",""))

                    Ism.softwares.each do |software|
                        if @name == software.name
                            temporaryVersion = SemanticVersion.parse(@version.tr("><=",""))

                            software.versions.each do |versionInformation|
                                temporarySoftwareVersion = SemanticVersion.parse(versionInformation.version.tr("><=",""))
                                if temporaryVersion < temporarySoftwareVersion && temporaryAvailableVersion < temporarySoftwareVersion
                                    availableVersion = temporarySoftwareVersion.to_s
                                else
                                    availableVersion = @version
                                end
                            end

                        end
                    end
                end

                if lessComparator
                    temporaryAvailableVersion = SemanticVersion.parse(@version.tr("><=",""))

                    Ism.softwares.each do |software|
                        if @name == software.name
                            temporaryVersion = SemanticVersion.parse(@version.tr("><=",""))

                            software.versions.each do |versionInformation|
                                temporarySoftwareVersion = SemanticVersion.parse(versionInformation.version.tr("><=",""))
                                if temporaryVersion > temporarySoftwareVersion && temporaryAvailableVersion > temporarySoftwareVersion
                                    availableVersion = temporarySoftwareVersion.to_s
                                else
                                    availableVersion = @version
                                end
                            end
                        end
                    end
                end

                if greaterOrEqualComparator
                    temporaryAvailableVersion = SemanticVersion.parse(@version.tr("><=",""))

                    Ism.softwares.each do |software|
                        if @name == software.name
                            temporaryVersion = SemanticVersion.parse(@version.tr("><=",""))

                            software.versions.each do |versionInformation|
                                temporarySoftwareVersion = SemanticVersion.parse(versionInformation.version.tr("><=",""))
                                if temporaryVersion <= temporarySoftwareVersion && temporaryAvailableVersion <= temporarySoftwareVersion
                                    availableVersion = temporarySoftwareVersion.to_s
                                else
                                    availableVersion = @version
                                end
                            end
                        end
                    end
                end

                if lessOrEqualComparator
                    temporaryAvailableVersion = SemanticVersion.parse(@version.tr("><=",""))

                    Ism.softwares.each do |software|
                        if @name == software.name
                            temporaryVersion = SemanticVersion.parse(@version.tr("><=",""))

                            software.versions.each do |versionInformation|
                                temporarySoftwareVersion = SemanticVersion.parse(versionInformation.version.tr("><=",""))
                                if temporaryVersion >= temporarySoftwareVersion && temporaryAvailableVersion >= temporarySoftwareVersion
                                    availableVersion = temporarySoftwareVersion.to_s
                                else
                                    availableVersion = @version
                                end
                            end
                        end
                    end
                end
            end

            return availableVersion
        end

        def information : ISM::SoftwareInformation
            dependencyInformation = Ism.getSoftwareInformation(@name,@version)

            @options.each do |option|
                dependencyInformation.enableOption(option)
            end

            return dependencyInformation
        end

        def dependencies : Array(ISM::SoftwareDependency)
            dependencyInformation = Ism.getSoftwareInformation(@name,@version)

            @options.each do |option|
                dependencyInformation.enableOption(option)
            end

            return dependencyInformation.dependencies
        end

        def == (other : ISM::SoftwareDependency) : Bool
            return hiddenName == other.hiddenName &&
            version == other.version &&
            @options == other.options
        end

    end

end
