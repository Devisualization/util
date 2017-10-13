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
module devisualization.util.opengl.camera;
import gl3n.linalg : mat3, vec3;
deprecated("de_util:opengl is going to die"):

/**
 * Provides a basic camera.
 * 
 * Based upon https://github.com/fogleman/pg/blob/master/pg/camera.py
 */
struct Camera {
    private {
        vec3 position_;
        float rx, ry;

        vec3 target_;
    }

    this(vec3 position) {
        position_ = position;
    }

    this(vec3 position, vec3 target) {
        position_ = position;
        lookAt(target);
    }

    @property {

        /**
         * Configures the rotation to look at a point
         * 
         * Params:
         *         t    =    The target to look at
         */
        void lookAt(vec3 t) {
            import std.math : PI, atan2, asin;
            target_ = t;

            //

            vec3 d = vec3(t.x - position_.x, t.y - position_.y, t.z - position_.z).normalized;
            rx = 2 * PI - (atan2(d.x, d.z) + PI);
            ry = asin(d.y);
        }

        /**
         * Configures the position of the matrix
         * Also recalls lookAt given the previous target
         * 
         * Params:
         *         position    =    The position to look from
         */
        void position(vec3 position) {
            position_ = position;
            lookAt(target_);
        }

        vec3 position() {
            return position_;
        }

        vec3 lookAt() {
            return target_;
        }

        /**
         * Gets the rotation matrix for current positon/rotation 
         */
        mat3 matrix(bool translate=true) {
            import std.math : cos, sin;
            mat3 matrix = mat3.identity;

			if (translate)
            	matrix = matrix.translate(-position_.x, -position.y, -position_.z);
            matrix = matrix.rotate(ry, vec3(cos(rx), 0, sin(rx)));
            matrix = matrix.rotate(-rx, vec3(0, 1, 0));

            return matrix;
        }
    }
}