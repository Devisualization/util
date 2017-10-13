/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2014 Devisualization (Richard Andrew Cattermole)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
module devisualization.util.opengl.shaders.defs;
import devisualization.util.opengl.function_wrappers;
import gl3n.linalg;
deprecated("de_util:opengl is going to die"):

class ShaderProgram {
	private {
		uint id_;
	}
	
	this(string vert, string frag=null, string geom=null) {
		import std.typecons : scoped;
		
		if (frag !is null && geom !is null) {
			auto vertS = scoped!Shader(vert, ShaderTypes.VertexShader);
			auto fragS = scoped!Shader(frag, ShaderTypes.FragmentShader);
			auto geomS = scoped!Shader(geom, ShaderTypes.GeometryShader);
			this(vertS, fragS, geomS);
		} else if (frag !is null) {
			auto vertS = scoped!Shader(vert, ShaderTypes.VertexShader);
			auto fragS = scoped!Shader(frag, ShaderTypes.FragmentShader);
			this(vertS, fragS, null);
		} else if (geom !is null) {
			auto vertS = scoped!Shader(vert, ShaderTypes.VertexShader);
			auto geomS = scoped!Shader(geom, ShaderTypes.GeometryShader);
			this(vertS, null, geomS);
		} else {
			auto vertS = scoped!Shader(vert, ShaderTypes.VertexShader);
			this(vertS, null, null);
		}
	}
	
	this(Shader vert = null, Shader frag = null, Shader geom = null) {
		// allocate the program
		id_ = glCreateProgram();
		if (vert !is null)
			attach(vert, false);
		if (frag !is null)
			attach(frag, false);
		if (geom !is null)
			attach(geom, false);
		link();
		bind();
	}
	
	~this() {
		// destroy the program
		glDeleteProgram(id_);
	}
	
	void attach(Shader shader, bool linkCall = true) {
		// attach the shader
		glAttachShader(id_, shader.id);
		if (linkCall)
			link();
	}
	
	void detach(Shader shader) {
		glDetachShader(id_, shader.id);
		link();
	}
	
	uint getAttribute(string name) {
		return glGetAttribLocation(id_, name);
	}
	
	uint getUniform(string name) {
		return glGetUniformLocation(id_, name);
	}
	
	@property {
		uint id() { return id_; }
	}
	
	void bind() {
		glUseProgram(id_);
	}
	
	void uniform(string name, mat2 value, bool transpose = false) {
		bind();
		glUniformMatrix2(getUniform(name), transpose, cast(float[])value.matrix);
	}
	
	void uniform(string name, mat3 value, bool transpose = false) {
		bind();
		glUniformMatrix3(getUniform(name), transpose, cast(float[])value.matrix);
	}
	
	void uniform(string name, mat4 value, bool transpose = false) {
		bind();
		glUniformMatrix4(getUniform(name), transpose, cast(float[])value.matrix);
	}
	
	void uniform(string name, vec2 value) {
		bind();
		glUniform(getUniform(name), cast(float[])value.vector);
	}
	
	void uniform(string name, vec3 value) {
		bind();
		glUniform(getUniform(name), cast(float[])value.vector);
	}
	
	void uniform(string name, vec4 value) {
		bind();
		glUniform(getUniform(name), cast(float[])value.vector);
	}
	
	void uniform(string name, float[2] value) {
		bind();
		glUniform(getUniform(name), value);
	}
	
	void uniform(string name, float[4] value) {
		bind();
		glUniform(getUniform(name), value);
	}
	
	void uniform(string name, bool value) {
		bind();
		glUniform(getUniform(name), value);
	}
	
	void uniform(string name, int[2] value) {
		bind();
		glUniform(getUniform(name), value);
	}
	
	void uniform(string name, int[4] value) {
		bind();
		glUniform(getUniform(name), value);
	}
	
	void uniform(string name, int value) {
		bind();
		glUniform(getUniform(name), value);
	}
	
	private {
		void link() {
			glLinkProgram(id_);
			
			int res;
			glGetProgram(id_, ProgramObjects.LinkStatus, res);
			if (!res)
				throw new Exception(getInfoLog());
		}
		
		string getInfoLog() {
			int res;
			glGetProgram(id_, ProgramObjects.InfoLogStatus, res);
			
			if (res > 0) {
				return glGetProgramInfoLog(id_);
			}
			return "";
		}
	}
}

class Shader {
	private {
		//ShaderObj id_;
		uint id_;
		ShaderTypes type_;
	}
	
	/**
     * Given either the source or filename(asset loader).
     */
	this(string source, ShaderTypes type) {
		// create
		id_ = glCreateShader(type_);
		opAssign(source);
		type_ = type;
		compile();
	}
	
	~this() {
		glDeleteShader(id_);
	}
	
	void opAssign()(string source) {
		// assign
		glShaderSource(id_, source);
		compile();
	}
	
	@property {
		ShaderTypes type() { return type_; }
		uint id() { return id_; }
	}
	
	private {
		void compile() {
			// compile
			glCompileShader(id_);
			
			int res;
			glGetShader(id_, ShaderObjects.CompileStatus, res);
			if (!res)
				throw new Exception(getInfoLog());
		}
		
		string getInfoLog() {
			int res;
			glGetShader(id_, ShaderObjects.InfoLogLength, res);
			
			if (res > 0) {
				return glGetProgramInfoLog(id_);
			}
			return "";
		}
	}
}