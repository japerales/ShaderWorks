Shader "Custom/BlendTest"
{
    Properties
    {
       
        _MainTex ("Albedo (RGB)", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }

        Blend One One
        Pass{
        //lo que hace este shader es pintar la superficie con _MainTex
        SetTexture[_MainTex] { combine texture }
        }
        
    }
}
