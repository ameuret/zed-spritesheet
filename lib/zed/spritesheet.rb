require "zed/spritesheet/version"
require "oily_png"

module ZED
  class Spritesheet

    PATH_REGEXP = /([.\/\w]*?)([-\w\d_.]+)$/.freeze
    PROJECT_URL = 'https://github.com/ameuret/zed-spritesheet'.freeze

    attr_reader :sprites, :pathBaseName, :path, :baseName, :spriteWidth, :spriteHeight

    def self.fromXML(pathBaseName, useExternalFiles = false)
      s = new pathBaseName:pathBaseName, useExternalFiles:useExternalFiles
      s.importXML
      s.checkExternalFilePresence if useExternalFiles
      s
    end
    
    def initialize(params)
      @sprites = {}
      @pathBaseName = params[:pathBaseName]
      @externalSprites = params[:useExternalFiles]
      @spriteWidth = params[:spriteWidth]
      @spriteHeight = params[:spriteHeight]
      
      splitPath @pathBaseName if @pathBaseName
    end

    def self.create(spritesheetFilePath, width, height, useExternalFiles = false)
      # s = new pathBaseName:File.basename(spritesheetFilePath, '.*'),
      s = new pathBaseName:spritesheetFilePath,
              useExternalFiles:useExternalFiles,
              spriteWidth: width,
              spriteHeight: height
      
      s.createSpritesFromGrid
      s.checkExternalFilePresence if useExternalFiles
      s
    end
    
    def [](name)
      s = @sprites[name]
      {path: (@externalSprites ? (@path + name) : @pathBaseName) + '.png',
       tile_x: s[:x],
       tile_y: s[:y],
       tile_w: s[:w],
       tile_h: s[:h]}
    end

    def export(forcedSpritePath = nil, outputPath = nil)
      importXML forcedSpritePath if forcedSpritePath
      outputPath ||= @pathBaseName + '.rb'
      if outputPath == STDOUT
        f = $stdout
      else
        f = File.open(outputPath, 'w+')
      end
      f.write("#Generated by Spritesheet#export (#{PROJECT_URL}).\n# DO NOT EDIT.\n")
      f.write("module Spritesheet\n")
      f.write("module #{@baseName.capitalize}\n")
      f.write("sprites = #{@sprites.to_s}\n")
      f.write("end\nend\n")
      f.close unless f == STDOUT
    end

    def importXML(forcedPath = nil)
      declaredPath = forcedPath || @path
      declaredPath += '/' unless declaredPath[-1] == '/'
      File.read(@pathBaseName + '.xml').each_line do
        |l|
        if l =~ /SubTexture\s+name="([-\w\d_]+).png"/
          name = $1
          if l =~ /x\s*=\s*"(\d+)"\s+y\s*=\s*"(\d+)"/
            x = Integer $1
            y = Integer $2
            if l =~ /width\s*=\s*"(\d+)"\s+height\s*=\s*"(\d+)"/
              w = Integer $1
              h = Integer $2
              @sprites[name] = {path: declaredPath + name + '.png', x:x, y:y, w:w, h:h}
            end
          end
          raise "Unsupported sprite sheet entry: #{l}" unless @sprites[name]
        end
      end
    end

    def checkExternalFilePresence
      @sprites.each {|k, v|
        #        puts "k: #{k}"
        #        puts "v: #{v}"
        File.read @path + k + '.png'}
    end

    def createSpritesFromGrid
      imagePath = Pathname.new(@path) + (@baseName + '.png')
      image = ChunkyPNG::Image.from_file(imagePath)
      cols = image.width / @spriteWidth
      rows = image.height / @spriteHeight
      rows.times do
        |rIdx|
        cols.times do
          |cIdx|
          @sprites['%s-%d-%d' % [@baseName, rIdx, cIdx]] = {path: imagePath.to_s, x:cIdx * @spriteWidth, y:rIdx * @spriteHeight, w:@spriteWidth, h:@spriteHeight}
        end
      end
    end

    protected
    def splitPath(fullPath)
      # Verify regex at https://regex101.com/r/Qc7vrL/1
      raise "Unrecognized path syntax: #{fullPath}" unless
        fullPath =~ PATH_REGEXP
      @path = $1 || 'X'
      @baseName = File.basename($2, '.*')
      # puts 'fp:' + fullPath
      # puts 'p: ' + @path
      # puts 'b: ' + @baseName
    end

  end
end

