using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.SqlClient;
using Nimap.Models;

namespace Nimap.Controllers
{
    public class HomeController : Controller
    {
        DbManager db = new DbManager();
        public ActionResult Index()
        {
            return View();
        }
        public JsonResult InsertCategory(NimapModel nm)
        {
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@action",nm.action),
                new SqlParameter("@id",nm.id),
                new SqlParameter("@cname",nm.cname)
            };
            DataTable tbl = db.TblDb("sp_category",parameters);
            if (tbl.Rows.Count > 0)
                return Json(tbl.Rows[0][0], JsonRequestBehavior.AllowGet);
            else
                if(nm.action==1)
                  return Json("Data Not Inserted...", JsonRequestBehavior.AllowGet);
                else if(nm.action==3)
                  return Json("Data Not Deleted...", JsonRequestBehavior.AllowGet);
                else
                  return Json("Data Not Updated...", JsonRequestBehavior.AllowGet);
        }
        public JsonResult SelectCategory()
       {
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@action",2) 
            };
            DataTable tbl = db.TblDb("sp_category", parameters);
            if (tbl.Rows.Count > 0)
            {
                List<NimapModel> list = new List<NimapModel>();
                foreach(DataRow row in tbl.Rows)
                {
                    list.Add(new NimapModel
                    {
                        id=Convert.ToInt32(row[0]),
                        cname=row[1].ToString()
                    });
                }
                return Json(list, JsonRequestBehavior.AllowGet);

            }
            else
                return Json("Data Not Selected...", JsonRequestBehavior.AllowGet);
        }
        public ActionResult About()
        {
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@action",2)
            };
            DataTable tbl = db.TblDb("sp_category", parameters);
            ViewBag.tbl =tbl;
            return View();
        }
        public JsonResult InsertProduct(NimapModel nm)
        {
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@action",nm.action),
                new SqlParameter("@id",nm.id),
                new SqlParameter("@pname",nm.pname),
                new SqlParameter("@cid",nm.cid)
            };
            DataTable tbl = db.TblDb("sp_product", parameters);
            if (tbl.Rows.Count > 0)
                return Json(tbl.Rows[0][0], JsonRequestBehavior.AllowGet);
            else
                if (nm.action == 1)
                return Json("Data Not Inserted...", JsonRequestBehavior.AllowGet);
            else if (nm.action == 3)
                return Json("Data Not Deleted...", JsonRequestBehavior.AllowGet);
            else
                return Json("Data Not Updated...", JsonRequestBehavior.AllowGet);
        }
        public JsonResult SelectProduct()
        {
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@action",2)
            };
            DataTable tbl = db.TblDb("sp_product", parameters);
            if (tbl.Rows.Count > 0)
            {
                List<NimapModel> list = new List<NimapModel>();
                foreach (DataRow row in tbl.Rows)
                {
                    list.Add(new NimapModel
                    {
                        id = Convert.ToInt32(row[0]),
                        pname=row[1].ToString(),
                        cid=Convert.ToInt32(row[2]),
                        cname = row[3].ToString()
                        
                    });
                }
                return Json(list, JsonRequestBehavior.AllowGet);

            }
            else
                return Json("Data Not Selected...", JsonRequestBehavior.AllowGet);
        }
        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    } 
}