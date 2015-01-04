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
module devisualization.util.opengl.renderbuffer;
import devisualization.util.opengl.function_wrappers;
import devisualization.util.opengl.texture;
import glINCOMPLETE = derelict.opengl3.gl3;

class RenderBuffer {
	private {
		uint id_;
	}

	this() {
		glINCOMPLETE.glGenRenderbuffers(1, &id_);
	}

	this(uint width, uint height, InternalFormat format) {
		this();
		bind();
		glINCOMPLETE.glRenderbufferStorage(glINCOMPLETE.GL_RENDERBUFFER, format, width, height);
	}

	~this() {
		glINCOMPLETE.glDeleteRenderbuffers(1, &id_);
	}

	void bind() {
		glINCOMPLETE.glBindRenderbuffer(glINCOMPLETE.GL_RENDERBUFFER, id_);
	}

	@property {
		uint id() {
			return id_;
		}
	}

	static {
		void unbind() {
			glINCOMPLETE.glBindRenderbuffer(glINCOMPLETE.GL_RENDERBUFFER, 0);
		}
	}
}