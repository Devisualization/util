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
module devisualization.util.opengl.shaders.solidcolor;
import devisualization.util.opengl.shaders.defs;
import devisualization.util.opengl.vertexarray;
import devisualization.util.opengl.buffers;
import devisualization.image.color;
import gl3n.linalg : vec4, mat4;
deprecated("de_util:opengl is going to die"):

/**
 * Renders vertices as a solid colour
 * 
 * Shader based upon https://github.com/fogleman/pg/blob/master/pg/programs.py
 */
class SolidColorShader : ShaderProgram {
	this() {
		super("""
#if __VERSION__ > 120
    #version 130
    in vec4 position;
#else
    #version 120
    attribute vec4 position;
#endif

uniform vec4 move;
uniform mat4 scale;
uniform mat4 transform;

void main() {
    gl_Position = ((scale * position) + move) * transform;
}
			""",
			"""
#if __VERSION__ > 120
    #version 130
    uniform vec4 color;

    out vec4 outColor;
    void main() {
        outColor = color;
    }
#else
    #version 120
    uniform vec4 color;

    void main() {
        gl_FragColor = color;
    }
#endif
		""");

		myColor = Color_RGBA(1f, 1f, 1f, 1f);
	}

	@disable {
		this(string vert, string frag=null, string geom=null){}
		this(Shader vert = null, Shader frag = null, Shader geom = null){}
	}

	@property {
		void myColor(Color_RGBA c) {
			uniform("color", vec4(c.r, c.g, c.b, c.a));
		}

		void move(vec4 v) {
			uniform("move", v);
		}

		void scale(mat4 m) {
			uniform("scale", m);
		}

		void transform(mat4 m) {
			uniform("transform", m);
		}

		void myVertices(VertexArray vao, IBuffer buffer) {
			import devisualization.util.opengl.function_wrappers.v20 : AttribPointerType;
			vao.bindAttribute(this, "position", buffer, AttribPointerType.Float, 4);
		}
	}
}