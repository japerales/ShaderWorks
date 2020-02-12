Shader "Holistic/BumpedEnvironment"
{
	Properties{
		_myDiffuse("Diffuse Texture", 2D) = "white" {}
		_myNormal("Normal Map Texture", 2D) = "bump" {}
		_mySlider("Bump Amount", Range(0,10)) = 1
		_myBright("Brightness", Range(0,10)) = 1
		_myCube("Cube Map", CUBE) = "white" {}
	}
		SubShader{

		  CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _myDiffuse;
			sampler2D _myNormal;
			half _mySlider; //half para sliders y valores de properties
			half _myBright;
			samplerCUBE _myCube;

			struct Input {
				float2 uv_myDiffuse;
				float2 uv_myNormal;
				float3 worldRefl; INTERNAL_DATA
			};
			/*Usamos INTERNAL_DATA cuando queremos usar reflexiones que se vean afectadas por el mapa de normales.
											Al parecer la información de reflexión y normales está de algún modo relacionada y no se puede modificar
											las normales y luego aplicar reflexiones con normales como si nada, ya que las normales estan basadas en la worldReflectionData
											.INTERNAL_DATA hace que worldRef y o.Normal no se afecten.
											De hecho para obtener reflexiones con normales
											hace falta usar la función WorldReflectionVector, que usa las normales para tenerlas en cuenta en la reflexión
											Si no quisieramos usar las normales simplemente usaríamos texCUBE(_myCube, worldRefl).rgb
											If you want to do reflections that are affected by normal maps
, it needs to be slightly more involved: INTERNAL_DATA needs to be added to the Input structure, and WorldReflectionVector
function used to compute per-pixel reflection vector after you’ve written the Normal output.*/
			void surf(Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
				o.Normal = UnpackNormal(tex2D(_myNormal, IN.uv_myNormal)) * _myBright;
				o.Normal *= float3(_mySlider, _mySlider, 1);
				o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
				//https://docs.unity3d.com/Manual/SL-SurfaceShaderExamples.html

			}

		  ENDCG
		}
			Fallback "Diffuse"
}
