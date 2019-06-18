package com.gps.common.util;

/**
 * 
 * @Description 计算一个点是否在一个多边形中
 * @author wgx
 * @param 
 * @throws
 */
public class Polygon {
	
	/// <summary>
	/// <para>判断点是否在多边形的范围内</para>
	/// <para>返回值：值为1表示点在多边形范围内；</para>
	/// <para>值为0表示点在多边形边上；</para>
	/// <para>值为-1表示点不在多边形范围内。</para>
	/// </summary>
	/// <param name="point">点坐标，长度为2</param>
	/// <param name="polyline">多边形节点坐标，长度为2*n，其中n应大于或等于3，即至少为三角形</param>
	/// <returns>
	/// <para>返回值：值为1表示点在多边形范围内；</para>
	/// <para>值为0表示点在多边形边上；</para>
	/// <para>值为-1表示点不在多边形范围内。</para>
	/// </returns>
	///说明:起始点没有包含在中间
	public static int PolygonIsContainPoint(double[] point,double[] polyline)
	{
		int result = -1, count = 0, pointcount = 0, tempI;
		double maxx = 0, minx = 0, maxy = 0, miny = 0;
		if (polyline != null)
		{
			int i;
			pointcount = polyline.length / 2;
			maxx = minx = polyline[0];
			maxy = miny = polyline[1];
			for (i = 0; i < pointcount; i++)
			{
				tempI = i + i;
				if (maxx < polyline[tempI])
					maxx = polyline[tempI];
				if (minx > polyline[tempI])
					minx = polyline[tempI];
				if (maxy < polyline[tempI + 1])
					maxy = polyline[tempI + 1];
				if (miny > polyline[tempI + 1])
					miny = polyline[tempI + 1];
			}
		}
		if (point != null)
		{

			// 首先判断是否在面的外框范围内
			if (point[0] < minx || point[0] > maxx
					|| point[1] < miny || point[1] > maxy)
			{
				return result;
			}
			else
			{
				int i, j;
				j = pointcount - 1;
				double[] point1, point2;
				double tempValue;
				for (i = 0; i < pointcount; i++)
				{
					point1 = new double[2];
					point2 = new double[2];
					tempI = i + i;
					point1[0] = polyline[tempI];
					point1[1] = polyline[tempI + 1];
					tempI = j + j;
					point2[0] = polyline[tempI];
					point2[1] = polyline[tempI + 1];
					if ((point1[0] < point[0] && point2[0] >= point[0])
							|| (point2[0] < point[0] && point1[0] >= point[0]))
					{
						tempValue=point1[1] + (point[0] - point1[0]) / (point2[0] - point1[0]) * (point2[1] - point1[1]);
						if (tempValue < point[1])
						{
							count++;
						}
						else if (tempValue == point[1])
						{
							count = -1;
							break;
						}
					}
					j = i;
				}
			}
		}
		if (count == -1)
		{
			result = 0;// 点在线段上
		}
		else
		{
			tempI = count % 2;
			if (tempI == 0)// 为偶数
			{
				result = -1;
			}
			else
			{
				result = 1;
			}
		}
		return result;
	}
	public static void main(String[] args){
		double[] polyline={25.24345,111.89123,29.90351,113.89251,30.00351,112.69123};//28.12345,112.59123
		double[] poly={30.00351,112.69123};
		int n=5;
		n=PolygonIsContainPoint(poly,polyline);
		System.out.println(n);
	}
}