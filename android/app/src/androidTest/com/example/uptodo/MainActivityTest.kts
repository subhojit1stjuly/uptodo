package com.example.uptodo;

import androidx.test.platform.app.InstrumentationRegistry
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters
import pl.leancode.patrol.PatrolJUnitRunner

@RunWith(Parameterized::class)
class MainActivityTest(private val dartTestName: String) {
    @Test
    fun runDartTest() {
        val instrumentation: PatrolJUnitRunner =
            InstrumentationRegistry.getInstrumentation() as PatrolJUnitRunner
        instrumentation.runDartTest(dartTestName)
    }

    companion object {
        @Parameters(name = "{0}")
        fun testCases(): Array<Any> {
            val instrumentation: PatrolJUnitRunner =
                InstrumentationRegistry.getInstrumentation() as PatrolJUnitRunner
            // replace "MainActivity.class" with "io.flutter.embedding.android.FlutterActivity.class"
            // if in AndroidManifest.xml in manifest/application/activity you have
            //     android:name="io.flutter.embedding.android.FlutterActivity"
            instrumentation.setUp(MainActivity::class.java)
            instrumentation.waitForPatrolAppService()
            return instrumentation.listDartTests()
        }
    }
}