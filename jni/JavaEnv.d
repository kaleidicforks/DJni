module jni.JavaEnv;

import std.stdio;
import std.algorithm;

import jni.jni;
import jni.JavaVM;
import jni.JavaClass;


struct JavaEnv {
public:
	// construct from scratch
	this(JNIEnv * env) {
		val = env;
	}


	JNIEnv * Val() {
		return val;
	}

	const(JNIEnv) * Val() const {
		return val;
	}

	bool valid() const {
		return val != null;
	}

	bool opEquals(JavaEnv env) const {
		return opEquals(env);
	}

	bool opEquals(ref const(JavaEnv) env) const {
		return val == env.val;
	}

	jint getVersion() const {
		return val.GetVersion();
	}

	JniJavaVM getVM() const {
		JavaVM * vm;
		if(val.GetJavaVM(&vm) != 0) {
			writeln("Error: cannot get JavaVM from JNIEnv!");
			return JniJavaVM(); // return invalid
		}
		return JniJavaVM(vm, getVersion());
	}

	JavaClass findClass(string str) {
		return JavaClass(this, str);
	}

private:
	JNIEnv * val;
}
