  require 'find'
  require 'fileutils'
  require 'yaml'

  ENVIRONMENT = 'development'
  config=YAML.load_file(ENVIRONMENT+'.yml')
  
  Find.find(config['source']) do |f|
    #loop through, acting on only the jpg and raw files
    if File.extname(f) == '.jpg' || File.extname(f) == '.rw2'
      moveFile(f)
    end
  end

 def moveFile(myFileName)
   # make an object based on the path passed, in order to access the file's 
	#	date information    
   myFile = File.new(myFileName)
    #check for the folder in the given location with the format YYYY-MM
    if checkDir(myFile.ctime.strftime('%Y'), myFile.ctime.strftime('%m'))
      # if folder created or not needed- go ahead and take action
      puts 'moving...' + File.name(myFileName) + ' TO: ' + config['base_dest'] + '/' + 
       myFile.ctime.strftime('%Y') + '/' + myFile.ctime.strftime('%m') + 
       '/' + File.basename(myFileName)
      FileUtils.move(myFileName, PIX_BASE_DEST + '/' + 
       myFile.ctime.strftime('%Y') + '/' + myFile.ctime.strftime('%m') + 
       '/' + File.basename(myFileName))
    end
 end
 
 def checkDir(myYear, myMonth)
   #does the year folder not exist?
    if not Dir.exists?(config['base_dest'] + '/' + myYear) 
    #then make it
      Dir.mkdir(config['base_dest'] + '/' + myYear)
    end
   #does the month folder not exist?
    if not Dir.exists?(config['base_dest'] + '/' + myYear + '/' + myMonth) 
    #then make it
      Dir.mkdir(config['base_dest'] + '/' + myYear + '/' + myMonth)
    end
    true
 end
 
