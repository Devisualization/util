/**
 * License:
 *              Copyright Devisualization (Richard Andrew Cattermole) 2014 - 2017.
 *     Distributed under the Boost Software License, Version 1.0.
 *        (See accompanying file LICENSE_1_0.txt or copy at
 *              http://www.boost.org/LICENSE_1_0.txt)
 */
module devisualization.util.core.assetmanager;

/**
 * Loads assest based upon, local to program, defaults, application provided, system locatiom and user location.
 * Supports bin2d's generated modules to load from.
 */
deprecated("An asset manager should be based upon a VFS.")
struct AssetManager(T) {
    private __gshared {
        T[string] local;
        T[string] defaults;
        T[string] apps;
        T[string] systems;
        T[string] users;
        
        string localPath, userPath, systemPath;
    }
	
	this(string dirIndex, string app, string company = null, string customSystemInstallDirectory=null) {
        import std.path : buildPath, baseName;
        import std.process : environment;
        localPath = buildPath(dirIndex);
        
        version(Windows) {
            if (company is null) {
                userPath = buildPath(environment["LOCALAPPDATA"], app, dirIndex);
                
                if (customSystemInstallDirectory is null)
					systemPath = buildPath(environment["PROGRAMFILES"], app, dirIndex);
                else
					systemPath = buildPath(customSystemInstallDirectory, app, dirIndex);
            } else {
                userPath = buildPath(environment["LOCALAPPDATA"], company, app, dirIndex);
                if (customSystemInstallDirectory is null)
					systemPath = buildPath(environment["PROGRAMFILES"], company, app, dirIndex);
                else
					systemPath = buildPath(customSystemInstallDirectory, company, app, dirIndex);
            }
        } else version(Posix) {
            if (company is null) {
                userPath = buildPath(environment["HOME"], app, dirIndex);
                
                if (customSystemInstallDirectory is null)
                    programFilesPath = buildPath("/usr/share", app, dirIndex);
                else
                    programFilesPath = buildPath(customSystemInstallDirectory, app, dirIndex);
            } else {
                userPath = buildPath(environment["HOME"], company, app, dirIndex);
                
                if (customSystemInstallDirectory is null)
                    programFilesPath = buildPath("/usr/share", company, app, dirIndex);
                else
                    programFilesPath = buildPath(customSystemInstallDirectory, company, app, dirIndex);
            }
        } else {
            static assert(0, "Have not implemented storage locations for platform.");
        }
        
        update();
    }
    
    /**
     * Registers a default assest value provided by the application
     *
     * Params:
     *     mod    =    Name of assest
     *     value  =    The value of the asset
     */
    void registerDefault(string mod, T value) { defaults[mod] = value; }
    
    /**
     * Registers an assest value provided by the application
     *
     * Params:
     *     mod    =    Name of asset
     *     value  =    The value of the asset
     */
    void registerApp(string mod, T value) { apps[mod] = value; }
    
    /**
     * Registers application assets that was compiled in via Bin2d
     *
     * Params:
     *     filterExtension  =    Extension of files to only use
     *     asDefault        =    Is this a default value or application override? Default: true (default value)
     */
    void registerFromBin2d(string bin2dmod)(string filterExtension, bool asDefault=true) {
        import std.algorithm : canFind;
        import std.string : tr;
        import std.path : extension;
        mixin("import " ~ bin2dmod ~ ";");
        
        foreach(i, fn; assetNames) {
			string oname = assetOriginalNames[i];
            if (oname.extension == filterExtension) {
                if (asDefault)
                    registerDefault(oname, cast(T)assetValues[i]);
                else
                    registerApp(oname, cast(T)assetValues[i]);
            }
        }
    }

    /**
     * Gets an assest based upon its name
     *
     * Params:
     *     mod    =    Name of asset
     */
    T opIndex(string mod) {
        if (mod in local) return local[mod];
        if (mod in apps) return apps[mod];
        if (mod in users) return users[mod];
        if (mod in systems) return systems[mod];
        return defaults.get(mod, T.init);
    }
    
    /**
     * Updates all files from the file system.
     * Looks in local to application, user application directories and system application directories
     */
    void update() {
        local = getFilesFromFileSystem(localPath);
        users = getFilesFromFileSystem(userPath);
        systems = getFilesFromFileSystem(systemPath);
    }
    
    private {
        import std.file : exists, mkdirRecurse, isDir, dirEntries, SpanMode, read, FileException;
		import std.path : baseName;
        
        T[string] getFilesFromFileSystem(string dir)
        in {
            try {
                if (exists(dir)) {
                    if (isDir(dir)) {
                        // directory exists.
                    } else {
                        // I don't know how to handle this *shrugs*
                    }
                } else {
                    mkdirRecurse(dir);
                }
            } catch (Error e) {
            } catch (Exception e) {
            }
        } body {
            T[string] ret;
            if (exists(dir) && isDir(dir)) {
                // once we get here we already _know_ the directory exists
                foreach(string entry; dirEntries(dir, SpanMode.shallow)) {
                    ret[baseName(entry)] = cast(T)read(entry);
                }
            }
            return ret;
        }
    }
}