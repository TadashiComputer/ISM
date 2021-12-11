class Target < ISM::Software

    def initialize
        super
        @information.name = "Binutils"
        @information.architectures = ["x86_64"]
        @information.description = "The GNU collection of binary tools"
        @information.website = "https://www.gnu.org/software/binutils/"
        @information.downloadLinks = ["https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.xz"]
        @information.signatureLinks = ["https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.xz.sig"]

        option1 = ISM::SoftwareOption.new
        option1.name = "Pass1"
        option1.description = "Build the first pass to make a system from scratch"

        option2 = ISM::SoftwareOption.new
        option2.name = "Pass2"
        option2.description = "Build the second pass to make a system from scratch"

        @information.options = [option1, option2] of ISM::SoftwareOption
    end

    def download
        super
        `wget https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.xz`
        `wget https://ftp.gnu.org/gnu/binutils/binutils-2.37.tar.sig`
    end
    
    def check
        super
        `gpg binutils-2.37.tar.xz.sig`
    end
    
    def extract
        super
        `tar -xf binutils-2.37.tar.xz`
    end
    
    def prepare
        super
        Dir.mkdir("build")
        Dir.cd("build")
    end
    
    def configure
        super
        if @information.options[0].active == true
            `../configure   --prefix=#{ism.settings.toolsPath}
                            --with-sysroot=#{ism.settings.rootPath}
                            --target=#{ism.settings.target}
                            --disable-nls
                            --disable-werror`
        elsif @options[1] == true
            `../configure   --prefix=/usr
                            --build=$(../config.guess)
                            --host=#{ism.settings.target}
                            --disable-nls
                            --enable-shared
                            --disable-werror
                            --enable-64-bit-bfd`
        else
            `../configure   --prefix=/usr
                            --enable-gold
                            --enable-ld=default
                            --enable-plugins
                            --enable-shared
                            --disable-werror
                            --enable-64-bit-bfd
                            --with-system-zlib`
        end
    end
    
    def build
        super
        if @information.options[0] || @information.options[1]
            `make`
        else
            `make tooldir=/usr`
        end
    end
    
    def install
        super
        if @information.options[0] == true
            `make -j1 install`
        elsif @information.options[1] == true
            `make DESTDIR=#{ism.settings.rootPath} install -j1`
            `install -vm755 libctf/.libs/libctf.so.0.0.0 #{ism.settings.rootPath}/usr/lib`
        else
            `make tooldir=/usr install -j1`
            `rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.a`
        end
    end
    
    def uninstall
        super
    end
    
    def enableOption(option)
        super
        if option == option1.name
            @information.options[0] = true
            @information.options[1] = false
        elsif option == option2.name
            @information.options[1] = true
            @information.options[0] = false
        else
            @information.options.each_with_index do |data, index|
                if data.name = option
                    @information.options[index] = true
                    break
                end
            end
        end
    end
    
    def disableOption(option)
        super
        @information.options.each_with_index do |data, index|
            if data.name = option
                @information.options[index] = false
                break
            end
        end
    end

end
