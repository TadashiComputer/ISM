require "colorize"
require "json"
require "../../../ISM/Default/SoftwareOption"
require "../../../ISM/SoftwareOption"
require "../../../ISM/Default/SoftwareDependency"
require "../../../ISM/SoftwareDependency"
require "../../../ISM/Default/SoftwareInformation"
require "../../../ISM/SoftwareInformation"
require "../../../ISM/Default/Software"
require "../../../ISM/Software"

class Target < ISM::Software

    def initialize
        super
        @information.loadInformationFile("./Softwares/Binutils-Pass1/2.37/Information.json")
    end

    def download
        `wget https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.xz`
        `wget https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.sig`
    end
    
    def check
        `gpg binutils-2.37.tar.xz.sig`
    end
    
    def extract
        `tar -xf binutils-2.37.tar.xz`
    end
    
    def patch
    end

    def prepare
        Dir.mkdir("build")
        Dir.cd("build")
    end
    
    def configure
        `../configure   --prefix=#{Ism.settings.toolsPath}
                        --with-sysroot=#{Ism.settings.rootPath}
                        --target=#{Ism.settings.target}
                        --disable-nls
                        --disable-werror`
    end
    
    def build
        `make #{Ism.settings.makeOptions}`
    end
    
    def install
        `make -j1 install`
    end
    
    def uninstall
    end

end