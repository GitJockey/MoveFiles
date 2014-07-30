#this is a comment to test the commit capability of this editor
class FileMover
 	ENVIRONMENT = 'development'
	def initialize
		require 'find'
		require 'fileutils'
		require 'yaml'
	  
		if config=YAML.load_file(ENVIRONMENT+'.yml')
			puts 'Configuration data loaded:'
			config.each_with_index {|val, index| puts "	#{val} => #{index}" }
			puts 
			if checkDir(config['source'])
				Find.find(config['source']) do |fileFound|
					#loop through, acting on only the jpg and raw files
					if File.extname(fileFound) == '.jpg' || File.extname(fileFound) == '.rw2'
					  moveFile(fileFound, config['base_dest'])
					end
				end
			else
				puts 'Source location (' + config['source'] + 'could not be accessed or created.'
			end
		else
			puts 'Unable to load lconfiguration file ' + ENVIRONMENT + '.yml'
		end
	end
	  
	 def moveFile(myFileName, baseDestination)
		# make an object based on the path passed, in order to access the file's 
		#date information    
		myFile = File.new(myFileName)
		#check for the folder in the given location with the format YYYY-MM
		if checkDir(baseDestination + '/' + myFile.ctime.strftime('%Y') + 
			'/' + myFile.ctime.strftime('%m'))
		   ##myFile.ctime.strftime('%Y') myFile.ctime.strftime('%m'))
		  # if folder created or not needed- go ahead and take action
		  puts 'moving...	FROM: ' + myFileName  
		  puts ' 		TO: ' + baseDestination + '/' + 
		   myFile.ctime.strftime('%Y') + '/' + myFile.ctime.strftime('%m') + 
		   '/' + File.basename(myFileName)
		  FileUtils.move(myFileName, baseDestination + '/' + 
		   myFile.ctime.strftime('%Y') + '/' + myFile.ctime.strftime('%m') + 
		   '/' + File.basename(myFileName))
		end
	 end
	 
	 def checkDir(myPath) #myYear, myMonth)
	   #does the folder exist?
		if Dir.exists?(myPath) 
			true
		else 
			#then make it
			FileUtils.mkpath(myPath)
		end
	 end

 end

fm = FileMover.new


 

