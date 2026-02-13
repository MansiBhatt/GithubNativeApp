package com.example.githubnativeapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Button
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import io.flutter.embedding.android.FlutterActivity

class MainActivity : ComponentActivity() {

    private val loadingState = mutableStateOf(false)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            NativeScreen(
                loadingState = loadingState,
                onClick = {
                    loadingState.value = true
                    openFlutter()
                }
            )
        }
    }

    override fun onResume() {
        super.onResume()
        loadingState.value = false
    }

    private fun openFlutter() {
        val intent = FlutterActivity
            .withCachedEngine(MyApplication.FLUTTER_ENGINE_ID)
            .build(this)
        intent.putExtra("route", "/repos")
        startActivity(intent)
    }

}

@Composable
fun NativeScreen(
    loadingState: MutableState<Boolean>,
    onClick: () -> Unit
) {
    val loading by loadingState

    Surface(modifier = Modifier.fillMaxSize()) {
        Column(
            modifier = Modifier.fillMaxSize(),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text("GITHUB", style = MaterialTheme.typography.headlineMedium)

            Spacer(modifier = Modifier.height(24.dp))

            Button(
                onClick = onClick,
                enabled = !loading
            ) {
                Text("Show Repos")
            }

            if (loading) {
                Spacer(modifier = Modifier.height(12.dp))
                CircularProgressIndicator(
                    modifier = Modifier.size(20.dp),
                    strokeWidth = 2.dp
                )
            }
        }
    }
}

