Shader "Holistic/PropChallenge4" 
{
    Properties {
        _myTex ("Diffuse Texture", 2D) = "white" {}
		_myEmi("Emissive Texture", 2D) = "white" {}
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
     
 
        sampler2D _myTex;
	sampler2D _myEmi;

        struct Input {
            float2 uv_myTex;
            float3 worldRefl;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) ).rgb;
            o.Emission = tex2D (_myEmi, IN.uv_myTex).rgb;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
