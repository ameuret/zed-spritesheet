RSpec.describe Zed::Spritesheet do

  
  it "has a version number (SEMVER 2.0.0)" do
    expect(Zed::Spritesheet::VERSION).not_to be nil
  end

  describe '.fromXML(pathBaseName, useExternalFiles = false)' do
    it 'loads an XML description (<TextureAtlas><SubTexture>)' do
      ZED::Spritesheet.fromXML 'citydetails'
    end

    it 'recognizes the ShoeBox JSON format' do
      pending 'figuring out ShoeBox\'s lingo on frames'
      raise
    end

    it 'supports full path + base name specification (basename => no file name extension)' do
      ss = ZED::Spritesheet.fromXML 'spec/assets/city/citydetails'
      expect(ss.path).to eq('spec/assets/city/')
      expect(ss.baseName).to eq('citydetails')
    end

    it 'supports simple file base name specification (basename => no file name extension)' do
      ss = ZED::Spritesheet.fromXML 'citydetails'
      expect(ss.path).to eq('')
      expect(ss.baseName).to eq('citydetails')
    end

    it 'supports external sprites files (it simply checks if the files are present for now. More to come.)' do
      expect do
        ZED::Spritesheet.fromXML 'spec/assets/citydetails-missingRef', true
      end.to raise_error Errno::ENOENT
    end
  end

  describe '.create(pathBaseName, width, height, useExternalFiles = false)' do
    it 'creates a set of sprites based on a monotone grid (where all sprites have identical dimensions)' do
      ss = ZED::Spritesheet.create 'spec/assets/sinestesia/explosion1.png', 256, 256
      expect(ss.sprites["explosion1-0-0"][:x]).to eq(0)
      expect(ss.sprites["explosion1-0-0"][:y]).to eq(0)

      expect(ss.sprites["explosion1-0-0"][:w]).to eq(256)
      expect(ss.sprites["explosion1-0-0"][:h]).to eq(256)

      expect(ss.sprites["explosion1-0-7"][:x]).to eq(1792)
      expect(ss.sprites["explosion1-0-7"][:y]).to eq(0)

      expect(ss.sprites["explosion1-7-7"][:x]).to eq(1792)
      expect(ss.sprites["explosion1-7-7"][:y]).to eq(1792)
    end
  end

  describe '#sprites' do
    it 'gives access to all sprites found in the atlas in the form of a Hash with the \'name\' field as key' do
      ss = ZED::Spritesheet.fromXML 'citydetails'
      expect(ss.sprites["cityDetails_007"][:x]).to eq(103)
      expect(ss.sprites["cityDetails_007"][:y]).to eq(64)
      expect(ss.sprites["cityDetails_007"][:w]).to eq(22)
      expect(ss.sprites["cityDetails_007"][:h]).to eq(37)
    end
  end  

  describe '#[name]' do
    it 'returns a Hash for a single sprite, compliant to DragonRuby\'s tiling keys' do
      baseName =  'citydetails'
      ss = ZED::Spritesheet.fromXML baseName
      h = ss["cityDetails_007"]
      expect(h[:path]).to eq(baseName + '.png')
      expect(h[:tile_x]).to eq(103)
      expect(h[:tile_y]).to eq(64)
      expect(h[:tile_w]).to eq(22)
      expect(h[:tile_h]).to eq(37)
    end
    
    it 'honors the base path for individual sprite files' do
      baseName =  'spec/assets/city/citydetails'
      ss = ZED::Spritesheet.fromXML baseName, true
      h = ss["cityDetails_007"]
      expect(h[:path]).to eq('spec/assets/city/cityDetails_007' + '.png')
    end  
  end

  describe '#export' do
    it 'generates a Ruby source file (next to the atlas file) describing the sprite sheet' do
      baseName =  'spec/assets/city/citydetails'
      ss = ZED::Spritesheet.fromXML baseName
      ss.export
      expect(File).to exist(baseName + '.rb')
    end

    it 'creates a Hash literal under the Spritesheet::<basename> namespace' do
      baseName =  'spec/assets/city/citydetails'
      ss = ZED::Spritesheet.fromXML baseName
      ss.export
      src = File.read(baseName + '.rb')
      expect(src).to include 'module Spritesheet'
      expect(src).to include "module #{ss.baseName.capitalize}"
      expect(src).to include "cityDetails_000\"=>{:path=>\"spec/assets/city/cityDetails_000.png\", :x=>125, :y=>64, :w=>22, :h=>37}"
    end

    it 'accepts an optional argument used to force a specific sprite path instead of using the path stated in the input atlas' do
      baseName =  'spec/assets/city/citydetails'
      ss = ZED::Spritesheet.fromXML baseName
      ss.export '../sprites/city'
      src = File.read(baseName + '.rb')
      expect(src).to include "cityDetails_000\"=>{:path=>\"../sprites/city/cityDetails_000.png\", :x=>125, :y=>64, :w=>22, :h=>37}"
    end

    it 'accepts a second optional argument to specify the output path instead of saving the Ruby file next to the source atlas file' do
      baseName =  'spec/assets/city/citydetails'
      outputSrcPath = '/tmp/zed-spritesheetTest.rb' 
      ss = ZED::Spritesheet.fromXML baseName
      ss.export(nil, outputSrcPath)
      src = File.read(outputSrcPath)
      expect(src).to include "cityDetails_000\"=>{:path=>\"spec/assets/city/cityDetails_000.png\", :x=>125, :y=>64, :w=>22, :h=>37}"
    end

    it 'outputs the generated Ruby code to the standard output when the second argument is STDOUT' do
      baseName =  'spec/assets/city/citydetails'
      ss = ZED::Spritesheet.fromXML baseName
      expectedCode = /Generated by Spritesheet#export/
      expect { ss.export(nil, STDOUT) }.to output(expectedCode).to_stdout
    end
  end
end
