module Jekyll

  class ProjectPage < Page
    def initialize(site, base, dir, project)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'project_index.html')
      self.data['project'] = project
      self.data['title'] = project
    end
  end

  class ProjectPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'project_index'
        dir = site.config['project_dir'] || 'project'
        site.projects.each_key do |project|
          project_dir = File.join(dir, Utils.slugify(project))
          site.pages << project.new(site, site.source, project_dir, project)
        end
      end
    end
  end

end
