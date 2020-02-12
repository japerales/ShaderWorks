Shader "Holistic/DotProduct"
{
    SubShader
    {

        CGPROGRAM
        #pragma surface surf Lambert

     
        struct Input
        {
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
			//dot entre el vector que apunta desde el pixel hacia la cámara y la normal en el world space
			//Esto hace que los valores que miren a la cámara estén blancos y los que más perpendiculares están, son negros.
            half dotp = dot(IN.viewDir, o.Normal);
            o.Albedo = float3(dotp, dotp, dotp);
			
			//o.Albedo = float3(0, 1- dot(IN.viewDir, o.Normal), 1);


        }
        ENDCG
    }
    FallBack "Diffuse"
}
