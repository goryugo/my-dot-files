require 'rake/clean'
HOME = ENV["HOME"]
CURRENT = Dir.pwd
 
Dir.chdir HOME
dotfiles = FileList[".emacs.el",".zshrc",".gitconfig"]
dotfiles.exclude(/\.$/,
/history$/,
                 ".ssh",
                 ".DS_Store",
                 ".Trash")
dotfiles.each{|file|
  dotfiles.include(FileList[File.join(file,"**","*")])
}
Dir.chdir CURRENT
copyfiles = FileList[".*"]
copyfiles.exclude(/\.$/)
CLEAN.include(dotfiles)
 
task :import => dotfiles
 
rule(/^\./ => [
                proc{|file_name| File.join(HOME,file_name)}
               ]) do |t|
  dest = File.join(CURRENT,t.name)
  if File.ftype(t.source) == "directory"
    mkdir_p dest, {:verbose => true}
  else
    install t.source, dest, {:verbose => true}
  end
end
 
task :delete_original => copyfiles do |t|
  copyfiles.each{|file|
    if FileTest.exist?(File.join(HOME,file))
      rm_r File.join(HOME,file), {:force => true, :verbose => true}
    end
  }
end
 
task :symlink => copyfiles do |t|
  copyfiles.each{|file|
    if split_all(file).length == 1
      symlink File.join(CURRENT,file), File.join(HOME,file), {:verbose => true}
    end
  }
end
 
task :force_symlink => [:delete_original, :symlink]
 
task :export => copyfiles do |t|
  copyfiles.each{|file|
    if split_all(file).length == 1
      cp_r File.join(CURRENT,file), File.join(HOME,file), {:verbose => true}
    end
  }
end
 
task :force_export => [:delete_original, :export]
 